<?php

namespace app\service\Pay;

use app\common\Curl;
use app\model\PropertyListing;
use app\model\PropertyListingImage;
use app\model\PropertyListingVideo;
use think\facade\Cache;
use think\facade\Db;
use app\model\PropertyListingOrder;
use think\facade\Log;

class xpay
{


    /**
     * 生成签名
     * @param array $params 需要签名的参数数组
     * @param string $key 商户密钥
     * @return string 签名结果
     */
    function getSign($params, $key) {
        // 1. 过滤空值和签名参数
        $params = array_filter($params, function($value, $key) {
            return $value !== '' && $value !== null && $key != 'sign' && $key != 'sign_type';
        }, ARRAY_FILTER_USE_BOTH);
        // 2. 按照参数名ASCII码从小到大排序
        ksort($params);
        // 3. 拼接成URL键值对
        $stringA = '';
        foreach ($params as $k => $v) {
            $stringA .= "{$k}={$v}&";
        }
        $stringA = rtrim($stringA, '&');
        // 4. 拼接商户密钥并进行MD5加密
        $stringSignTemp = $stringA . $key;
        return md5($stringSignTemp);
    }

    /**
     * api请求
     */
    public function xpay(array $param): array
    {

        $redis = Cache::store('redis')->handler();
        if ($redis->sCard("user_orders:{$param['openid']}") > 0) {
            return ['success' => false, 'msg' => '请先处理已有订单！','data' => []];
        }
        $url = 'https://mzf.akwl.net/xpay/epay/mapi.php';
        $result = Curl::post($url, $param);
//        Log::info('请求 URL: ' . $url);
//        Log::info('请求参数: ' . json_encode($param, JSON_UNESCAPED_UNICODE));
//        Log::info('返回结果: ' . json_encode($result, JSON_UNESCAPED_UNICODE));
        if ($result['code'] == 1) {
            return ['success' => true, 'msg' => '查询成功', 'data' => $result];
        }
        return ['success' => false, 'msg' => '接口错误：' . ($result['msg'] ?? '未知错误'), 'data' => $result];
    }
    /**
     * 支付验证
     */
    public function checkxpay(array $param): array
    {
        $url = 'https://mzf.akwl.net/xpay/epay/api.php';
        $redis = Cache::store('redis')->handler();
        //redis
        if (empty($param['trade_no'])) {
            $orderSetKey = "user_orders:{$param['openid']}";
            $orderCount = $redis->sCard($orderSetKey);
            if ($orderCount > 0) {
                $orderNos = $redis->sMembers($orderSetKey);
                $param['trade_no'] = reset($orderNos);
            }
        }
        //mysql
        if (empty($param['trade_no'])) {
            $param['trade_no'] = PropertyListingOrder::where('openid', $param['openid'])
                ->where('status', false)
                ->order('create_time', 'desc')
                ->value('trade_no');
        }
        if (empty($param['trade_no'])) {
            return [
                'success' => true,
                'msg' => '未找到可验证的订单',
            ];
        }
        $result = Curl::post($url, $param);

        if ($result['code'] == 1 && $result['status'] == 1) {
            $redis = Cache::store('redis')->handler();
            $trade_no = $param['trade_no'];
            $openid = $param['openid'];
            PropertyListingOrder::where('trade_no',$trade_no)->update(['status' => true]);
            PropertyListing::with([
                'postpone'
            ]);

            Cache::store('redis')->delete("user_order:{$trade_no}");
            $redis->sRem("user_orders:{$openid}", $trade_no);
            return [
                'success' => true,
                'msg' => '支付验证成功，订单已上架',
            ];
        }else if($result['code'] == 1 && $result['status'] == 0){
            return [
                'success' => true,
                'msg' => '未支付！',
            ];
        }
        return [
            'success' => false,
            'msg' => '接口错误：' . ($result['msg'] ?? '未知错误'),
        ];
    }

}