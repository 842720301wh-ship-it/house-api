<?php

namespace app\model;

use think\Model;

/**
 * 账号
 */
class Account extends Model
{
    // 表名
    protected $name = 'account';

    // 自动时间戳
    protected $autoWriteTimestamp = false;
}