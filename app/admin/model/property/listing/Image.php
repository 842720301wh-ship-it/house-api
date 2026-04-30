<?php

namespace app\admin\model\property\listing;

use think\Model;

/**
 * Image
 */
class Image extends Model
{
    // 表名
    protected $name = 'property_listing_image';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;


    public function propertyListing(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\property\Listing::class, 'property_listing_id', 'id');
    }
}