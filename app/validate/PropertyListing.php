<?php

namespace app\validate;

use think\Validate;

class PropertyListing extends Validate
{
    protected $rule = [
        'openid'       => 'require',
        'city'         => 'require',
        'address'      => 'require',
        'rentType'     => 'require',
        'house'        => 'require',
        'area'         => 'require',
        'money'        => 'require',
        'introduction' => 'require',
        'telephone'    => 'require',
        'type'         => 'require',
        'videoUrl'     => 'require',
        'pictureUrl'   => 'require',
        'trade_no'     => 'require',
        'payurl'       => 'require',
        'id'           => 'require',
        'property_listing_id'  => 'require',
        'lat'            => 'require',
        'lng'            => 'require',
    ];

    protected $message = [
        'openid.require'                => '账号id不能为空~',
        'city.require'                  => '城市不能为空~',
        'address.require'               => '详细地址不能为空~',
        'rentType.require'              => '出租方式不能为空',
        'house.require'                 => '户型不能为空',
        'area.require'                  => '面积不能为空',
        'money.require'                 => '价格不能为空',
        'introduction.require'          => '详细介绍不能为空',
        'telephone.require'             => '联系方式不能为空',
        'type.require'                  => '类型不能为空',
        'videoUrl.require'              => '视频不能为空',
        'pictureUrl.require'            => '图片不能为空',
        'trade_no.require'              => '订单号不能为空',
        'payurl.require'                => '支付url不能为空',
        'id.require'                    => '对象丢失',
        'property_listing_id.require'   => '对象丢失',
        'lat.require'                    => '纬度丢失',
        'lng.require'                    => '经度丢失',

    ];

    //
    protected $scene = [
        'add' => ['openid', 'city', 'address','rentType','house','area','money','introduction','telephone','type','trade_no','payurl','lat','lng'],
        'update' => ['area','money','introduction','telephone','id'],
        'postpone' => ['trade_no','id'],
        'delete' => ['trade_no'],
        'rent' =>['city',],
        'buy' =>['city',],
        'visitor' => ['property_listing_id'],
        'favorites' => ['property_listing_id']
    ];
}