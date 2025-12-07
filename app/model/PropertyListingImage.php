<?php

namespace app\model;

use think\Model;

/**
 * 房源图片
 */
class PropertyListingImage extends Model
{
    // 表名
    protected $name = 'property_listing_image';

    // 自动时间戳
    protected $autoWriteTimestamp = false;
}