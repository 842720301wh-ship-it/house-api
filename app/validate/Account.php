<?php

namespace app\validate;

use think\Validate;

class Account extends Validate
{
    protected $rule = [
        'openid'        => 'require',
        'nickname'      => 'require',
        'time'          => 'require',
        'code'          => 'require',

    ];

    protected $message = [
        'openid.require'     => '账号id不能为空~',
        'nickname.require'   => '昵称不能为空~',
        'time.require'          => '登录已过期~',
        'code.require'       => 'code缺失',
    ];

    //
    protected $scene = [
        'publish' => ['openid', 'type', 'text'],
    ];
}