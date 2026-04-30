<?php

namespace app\admin\model\dynamic;

use think\Model;

/**
 * Video
 */
class Video extends Model
{
    // 表名
    protected $name = 'dynamic_video';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;


    public function dynamic(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\Dynamic::class, 'dynamic_id', 'id');
    }
}