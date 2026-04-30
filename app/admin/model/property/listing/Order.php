<?php

namespace app\admin\model\property\listing;

use think\Model;

/**
 * Order
 */
class Order extends Model
{
    // 表名
    protected $name = 'property_listing_order';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;
    protected $updateTime = false;


    public function propertyListing(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\property\Listing::class, 'property_listing_id', 'id');
    }
}