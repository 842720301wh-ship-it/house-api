<?php

namespace app\admin\model\property;

use think\Model;

/**
 * Listing
 */
class Listing extends Model
{
    // 表名
    protected $name = 'property_listing';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 字段类型转换
    protected $type = [
        'time' => 'timestamp:Y-m-d H:i:s',
    ];


    public function openidTable(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\Account::class, 'openid', 'openid');
    }
}