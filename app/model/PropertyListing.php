<?php

namespace app\model;

use think\db\BaseQuery;
use think\Model;

/**
 * 房源信息
 */
class PropertyListing extends Model
{
    // 表名
    protected $name = 'property_listing';

    // 自动时间戳
    protected $autoWriteTimestamp = false;

    /**
     * 图片
     */
    public function images(): \think\model\relation\HasMany
    {
        return $this->hasMany(PropertyListingImage::class, 'property_listing_id', 'id')
            ->order('sort', 'asc');
    }
    /**
     * 视频
     */
    public function videos(): \think\model\relation\HasMany
    {
        return $this->hasMany(PropertyListingVideo::class, 'property_listing_id', 'id')
            ->order('sort', 'asc');
    }
    /**
     * 订单
     */
    public function latestOrder(): \think\model\relation\HasOne
    {
        return $this->hasOne(PropertyListingOrder::class, 'property_listing_id', 'id')
            ->where('status', true);
    }
    /**
     * 收藏
     */
    public function favorites(): \think\model\relation\HasOne
    {
        return $this->hasOne(PropertyListingFavorites::class, 'property_listing_id', 'id');
    }
    /**
     * 延期
     */
    public function postpone(): \think\model\relation\HasMany
    {
        return $this->HasMany(PropertyListingOrder::class, 'property_listing_id', 'id')
            ->where('status', true)
            ->where('type','延期')
            ->selsect();
    }

    /**
     * 归属
     */
    public function account(): \think\model\relation\HasOne
    {
        return $this->hasOne(Account::class, 'openid', 'openid');
    }

    /**
     * 访客
     */
    public function visitor(): \think\model\relation\HasMany
    {
        return $this->hasMany(PropertyListingVisitor::class, 'property_listing_id', 'id')
            ->order('id', 'asc');
    }

    /**
     * 通用查询方法
     *
     * @return BaseQuery
     */
    public static function baseQuery()
    {

        $query = self::with(['images', 'videos', 'latestOrder', 'account','visitor'])
            ->where('time', '>', time())
            ->hasWhere('latestOrder', ['status' => true])
            ->order('id', 'desc');

        return $query;
    }
    /**
     * 收藏访问器
     */
    public function getFavoritesAttr($value, $data)
    {
        if (isset($data['_favorites_cache'])) {
            return $data['_favorites_cache'];
        }
        return false;
    }

    /**
     * 批量附加收藏状态
     *
     * @param array $listings 房源数组
     * @param string $openid 当前用户 openid
     * @return array
     */
    public static function attachFavorites(array $listings,  string $openid): array
    {
        // 取出所有房源ID
        $listingIds = array_column($listings, 'id');

        if (!$listingIds) {
            return $listings;
        }

        $favIds = PropertyListingFavorites::where('openid', $openid)
            ->whereIn('property_listing_id', $listingIds)
            ->column('property_listing_id');

        foreach ($listings as &$item) {
            if ($item instanceof Model) {
                $item->setAttr('_favorites_cache', in_array($item->id, $favIds));
            } else {
                $item['_favorites_cache'] = in_array($item['id'], $favIds);
            }
        }
        unset($item);

        return $listings;
    }
}