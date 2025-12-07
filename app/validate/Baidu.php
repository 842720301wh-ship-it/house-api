<?php

namespace app\validate;

use think\Validate;

class Baidu extends Validate
{
    protected $rule = [
        'keyword'       => 'require',
        'ak'            => 'require',
        'sub_admin'     => 'require',
        'query'         => 'require',
        'region'        => 'require',

    ];

    protected $message = [
        'keyword.require'       => '行政区划关键字不能为空~',
        'ak.require'            => 'ak不能为空~',
        'sub_admin.require'     => '子级级数不能为空~',
        'query.require'         => '关键字不能为空~',
        'region.require'        => '城市不能为空~',
    ];

    //
    protected $scene = [
        'get'    => ['keyword', 'ak', 'sub_admin'],
        'region' => ['region', 'ak', 'query','ak'],

    ];
}