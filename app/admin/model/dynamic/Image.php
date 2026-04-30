<?php

namespace app\admin\model\dynamic;

use think\Model;

/**
 * Image
 */
class Image extends Model
{
    // 表名
    protected $name = 'dynamic_image';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;


    public function dynamic(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\Dynamic::class, 'dynamic_id', 'id');
    }
}