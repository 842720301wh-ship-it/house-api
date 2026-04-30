<?php

namespace app\admin\model;

use think\Model;

/**
 * Dynamic
 */
class Dynamic extends Model
{
    // 表名
    protected $name = 'dynamic';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;
    protected $updateTime = false;


    public function openidTable(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\Account::class, 'openid', 'openid');
    }
}