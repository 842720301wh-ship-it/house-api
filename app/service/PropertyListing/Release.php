<?php

namespace app\service\PropertyListing;

use app\model\PropertyListing;
use app\model\PropertyListingImage;
use app\model\PropertyListingOrder;
use app\model\PropertyListingVideo;
use think\facade\Cache;
use think\facade\Db;
use think\facade\Filesystem;

class Release
{
    protected int $expire = 5 * 60; // 5分钟

    /**
     * 上传房源信息
     */
    public function add($param)
    {
        $redis = Cache::store('redis')->handler();
        if ($redis->sCard("user_orders:{$param['openid']}") > 0) {
            return ['success' => false, 'msg' => '请先处理已有订单！'];
        }
        if ($param['status'] === false) {
            // 写入数据库（开启事务）
            Db::startTrans();
            try {
                $orderData = json_encode($param);
                Cache::store('redis')->set("user_order:{$param['trade_no']}", $orderData, $this->expire);
                $setKey = "user_orders:{$param['openid']}";
                Cache::store('redis')->sAdd($setKey, $param['trade_no']);
                Cache::store('redis')->expire($setKey, $this->expire);

                $userid = PropertyListing::insertGetId([
                    'openid'       => $param['openid'],
                    'city'         => $param['city'],
                    'address'      => $param['address'],
                    'rentType'     => $param['rentType'],
                    'house'        => $param['house'],
                    'area'         => $param['area'],
                    'money'        => $param['money'],
                    'introduction' => $param['introduction'],
                    'telephone'    => $param['telephone'],
                    'type'         => $param['type'],
                    'trade_no'     => $param['trade_no'],
                    'lat'           => $param['lat'],
                    'lng'            => $param['lng'],
                    'time'         => time() + 30 * 24 * 60 * 60,
                ]);
                PropertyListingOrder::create([
                    'openid'        => $param['openid'],
                    'trade_no'      => $param['trade_no'],
                    'status'        => $param['status'],
                    'create_time'   => time(),
                    'property_listing_id'  => $userid,
                    'type'           => '上架',
                ]);
                if (!empty($param['videoUrl'])) {
                    $videos = is_string($param['videoUrl'])
                        ? json_decode($param['videoUrl'], true)
                        : $param['videoUrl'];
                    $sort = 1;
                    foreach ($videos as $url) {
                        PropertyListingVideo::create([
                            'property_listing_id' => $userid,
                            'file' => $url,
                            'sort' => $sort++,
                        ]);
                    }
                }

                if (!empty($param['pictureUrl'])) {
                    $pictures = is_string($param['pictureUrl'])
                        ? json_decode($param['pictureUrl'], true)
                        : $param['pictureUrl'];
                    $sort = 1;
                    foreach ($pictures as $url) {
                        PropertyListingImage::create([
                            'property_listing_id' => $userid,
                            'file' => $url,
                            'sort' => $sort++,
                        ]);
                    }
                }

                Db::commit();

                return [
                    'success' => true,
                    'msg' => '加入订单成功！',
                ];

            } catch (\Exception $e) {
                Db::rollback();
                return ['success' => false, 'msg' => '写入数据库失败：' . $e->getMessage()];
            }
        }

        return ['success' => false, 'msg' => '提交失败'];
    }

    /**
     * 修改房源信息
     */
    public function update($param)
    {
            // （开启事务）
            Db::startTrans();
            try {
                $user = PropertyListing::where('id', $param['id'])->update([
                    'area'         => $param['area'],
                    'money'        => $param['money'],
                    'introduction' => $param['introduction'],
                    'telephone'    => $param['telephone'],
                ]);

                $videos = is_string($param['videoUrl'])
                    ? json_decode($param['videoUrl'], true)
                    : $param['videoUrl'];

                if ($videos !== null) {
                    PropertyListingVideo::where('property_listing_id', $param['id'])->delete();

                    $sort = 1;
                    foreach ($videos as $url) {
                        PropertyListingVideo::create([
                            'property_listing_id' => $param['id'],
                            'file' => $url,
                            'sort' => $sort++,
                        ]);
                    }
                }

                $pictures = is_string($param['pictureUrl'])
                    ? json_decode($param['pictureUrl'], true)
                    : $param['pictureUrl'];

                if ($pictures !== null) {
                    $sort = 1;
                    // 先删除旧图片
                    PropertyListingImage::where('property_listing_id', $param['id'])->delete();

                    foreach ($pictures as $url) {
                        PropertyListingImage::create([
                            'property_listing_id' => $param['id'],
                            'file' => $url,
                            'sort' => $sort++,
                        ]);
                    }
                }

                Db::commit();

                return [
                    'success' => true,
                    'msg' => '修改成功！',
                ];

            } catch (\Exception $e) {
                Db::rollback();
                return ['success' => false, 'msg' => '写入数据库失败：' . $e->getMessage()];
            }
    }

    /**
     * 房源附加图片上传
     */
    public function image($file = null): array
    {
        try {
            if ($file) {
                $name = Filesystem::disk('public')->putFile('房源图片', $file);
                $url = Filesystem::disk('public')->url($name);
                return ['success' => true, 'data' => $url, 'msg' => '成功'];
            }
        } catch (\Exception $e) {
                return ['success' => false, 'msg' => '图片添加失败：' . $e->getMessage()];
            }
        return ['success' => false, 'msg' => '图片添加失败'];

    }

    /**
     * 房源附加视频上传
     */
    public function video($file = null): array
    {
        try {
            if ($file) {
                $name = Filesystem::disk('public')->putFile('房源视频', $file);
                $url = Filesystem::disk('public')->url($name);
                return ['success' => true, 'data' => $url, 'msg' => '成功'];
            }
        }catch (\Exception $e) {
        return ['success' => false, 'msg' => '视频添加失败：' . $e->getMessage()];
    }
        return ['success' => false, 'msg' => '视频添加失败'];
    }

    /**
     * 取出订单信息
     */
    public function getorder($openid)
    {
        $redis = Cache::store('redis')->handler();

        $orderCount = $redis->sCard("user_orders:{$openid}");
        if ($orderCount == 0) {
            return [
                'success' => true,
                'msg' => '用户暂无未支付订单',
                'data' => null
            ];
        }

        $orderNos = $redis->sMembers("user_orders:{$openid}");
        $trade_no = reset($orderNos);

        $order = Cache::store('redis')->get("user_order:{$trade_no}");
        if ($order) {
            $order = json_decode($order, true);
        }
        if (!$order) {
            return [
                'success' => false,
                'msg' => '未找到对应订单数据',
                'data' => null
            ];
        }

        $expire = $redis->ttl("user_order:{$trade_no}");

        return [
            'success' => true,
            'msg' => '查找成功',
            'data' => [
                'order'  => $order,
                'expire' => $expire,
            ]
        ];
    }

    /**
     *获取房源信息
     * @param string|null $openid
     * @param array $param
     * @return array
     */
    public function getUserListings(?string $openid, array $param): array
    {
        try {
            $listings = PropertyListing::baseQuery()
                ->where('type', $param['type'])
                ->where('openid', $openid)
                ->page($param['page'] ?? 1, $param['pageSize'] ?? 10)
                ->select()
                ->toArray();

            if (empty($listings)) {
                return [
                    'success' => true,
                    'msg' => '暂无上架房源',
                    'data' => [],
                ];
            }

            foreach ($listings as &$item) {
                if (!empty($item['time'])) {
                    $remaining = $item['time'] - time();
                    $item['expire_seconds'] = max($remaining, 0);
                }
            }

            $listings = (new \app\common\Limit)->filterFields($listings,
                ['address','area','city','expire_seconds','house','id','introduction','money','rentType','telephone','type',
                    'trade_no'],
                [
                    'images' => ['file'],
                    'videos' => ['file'],
                    'latestOrder' => ['create_time','trade_no','status','type'],
                    'account' => ['nickname','avatar'],
                ]
            );

            return [
                'success' => true,
                'msg' => '获取成功',
                'data' => $listings,
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'msg' => '获取失败：' . $e->getMessage(),
                'data' => [],
            ];
        }
    }

    /**
     * 房源延期
     */
    public function postpone($param)
    {
        $redis = Cache::store('redis')->handler();
        if ($redis->sCard("user_orders:{$param['openid']}") > 0) {
            return ['success' => false, 'msg' => '请先处理已有订单！'];
        }
       try{
           $setKey = "user_orders:{$param['openid']}";
           Cache::store('redis')->sAdd($setKey, $param['trade_no']);
           Cache::store('redis')->expire($setKey, $this->expire);
           $result = PropertyListingOrder::create([
               'openid'        => $param['openid'],
               'trade_no'      => $param['trade_no'],
               'status'        => $param['status'],
               'create_time'   => time(),
               'property_listing_id'  => $param['id'],
               'type'          => '延期',
           ]);

           return [
               'success' => true,
               'msg' => '下单成功',
           ];
       }catch (\Exception $e){
           return [
               'success' => false,
               'msg' => '下单失败：' . $e->getMessage(),
           ];
       }
    }

    /**
     * 删除订单
     */
    public function deletePost($param)
    {
        try {
            $redis = Cache::store('redis');

            $userOrdersKey = "user_orders:{$param['openid']}";
            $userOrderKey  = "user_order:{$param['trade_no']}";

            $deletedKeys = [];

            if ($redis->has($userOrdersKey)) {
                $redis->del($userOrdersKey);
                $deletedKeys[] = $userOrdersKey;
            }

            if ($redis->has($userOrderKey)) {
                $redis->del($userOrderKey);
                $deletedKeys[] = $userOrderKey;
            }

            return [
                'success' => true,
                'msg' => '删除成功',
                'deleted_keys' => $deletedKeys,
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'msg' => '删除失败：' . $e->getMessage(),
            ];
        }
    }


}