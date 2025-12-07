<?php

namespace app\validate;

use think\Validate;

class Pay extends Validate
{
    protected $rule = [
        'openid'        => 'require',
        'name'          => 'require',
        'money'         => 'require',
        'out_trade_no'  => 'require',
        'pid'           => 'require',
        'type'          => 'require',
        'sign'          => 'require',
        'trade_no'      => 'require',
        'key'           => 'require',
    ];

    protected $message = [
        'openid.require'                => '账号id不能为空~',
        'name.require'                  => '商品名称不能为空~',
        'money.require'                 => '价格不能为空~',
        'out_trade_no.require'          => '订单号不能为空',
        'pid.require'                   => '商户ID不能为空',
        'type.require'                  => '支付方式不能为空',
        'sign.require'                  => '签名不能为空',
        'trade_no.require'              => '订单号不能为空',
        'key.require'                   => '密钥不能为空',


    ];

    //
    protected $scene = [
        'pay' => [ 'name', 'money','out_trade_no','pid','type','sign','key'],
        'check' => ['key','pid',]
    ];
}