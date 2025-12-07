<?php

namespace app\controller;

use app\common\Response;
use app\service\PropertyListing\Release;
use app\service\PropertyListing\User;
use app\validate\PropertyListing as PropertyListingValidate;
use think\exception\ValidateException;
use think\Request;
use think\response\Json;

class PropertyListing
{
    protected Release $Release;
    protected User $User;

    public function __construct(Release $Release, User $User)
    {
        $this->Release = $Release;
        $this->User = $User;
    }

    /**
     * 添加房源信息
     * @param Request $request
     * @return Json
     */
    public function add(Request $request): \think\response\Json
    {
        $openid = $request->openid;
        $param = request()->only([
            'city',
            'address',
            'rentType',
            'house',
            'area',
            'money',
            'introduction',
            'telephone',
            'type',
            'videoUrl',
            'pictureUrl',
            'trade_no',
            'payurl',
            'lat',
            'lng'
        ], 'post');
        $param['openid'] = $openid;
        $param['status'] = input('post.status',false);
        try {
            validate(PropertyListingValidate::class)
                ->scene('add')
                ->check($param);
            if ($param['type'] === '买卖') {
                if (!empty($param['money'])) {
                    $param['money'] = (float)$param['money'] * 10000;
                }
            }
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->Release->add($param);
        if ($result['success']) {
            return json(Response::success(
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 修改房源信息
     * @param Request $request
     * @return Json
     */
    public function update(Request $request): \think\response\Json
    {
        $param = request()->only([
            'id',
            'area',
            'money',
            'introduction',
            'telephone',
            'videoUrl',
            'pictureUrl',
        ], 'post');
        $param['openid'] = $request->openid;
        try {
            validate(PropertyListingValidate::class)
                ->scene('update')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->Release->update($param);
        if ($result['success']) {
            return json(Response::success(
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 获取订单信息
     * @param Request $request
     * @return Json
     */
    public function getorder(Request $request): \think\response\Json
    {
        $openid = $request->openid;
        $result = $this->Release->getorder($openid);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 获取房源信息
     * @param Request $request
     * @return Json
     */
    public function get(Request $request): \think\response\Json
    {
        $openid = $request->openid;
        $param = request()->only([
            'page',
            'type',
            'pageSize',
        ], 'post');
        $result = $this->Release->getUserListings($openid,$param);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }
    /**
     * 获取收藏房源信息
     * @param Request $request
     * @return Json
     */
    public function getFavorites(Request $request): \think\response\Json
    {
        $openid = $request->openid;
        $param = request()->only([
            'page',
            'type',
            'pageSize',
        ], 'post');
        $result = $this->User->getFavorites($openid,$param);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }
    /**
     * 获取房源信息（主页）
     * @param Request $request
     * @return Json
     */
    public function getHome(Request $request): \think\response\Json
    {
        $openid = $request->header('openid')?: $request->post('openid');
        $param = request()->only([
            'page',
            'pageSize',
            'type',
            'city',
            'address',
            'sort',
            'Mixmoney',
            'Maxmoney',
            'Mixarea',
            'Maxarea',
            'house',
            'rentType'
        ], 'post');
        if (empty($param['city'])) {
            $param['city'] = '佛山市';
        }
        try {
            if($param['type'] == '租房'){
                validate(PropertyListingValidate::class)
                    ->scene('rent')
                    ->check($param);
            }else if($param['type'] == '买房'){
                validate(PropertyListingValidate::class)
                    ->scene('buy')
                    ->check($param);
                if ($param['type'] === '买房') {
                    if (!empty($param['Mixmoney'])) {
                        $param['Mixmoney'] = (float)$param['Mixmoney'] * 10000;
                    }
                    if (!empty($param['Maxmoney'])) {
                        $param['Maxmoney'] = (float)$param['Maxmoney'] * 10000;
                    }
                }

            }else{
                return json(Response::error(
                    message: '请求失败！'
                ));
            }
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->User->getHomeListings($openid,$param);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 上传附加图片
     * @param Request $request
     * @return Json
     */
    public function image(Request $request): \think\response\Json
    {
        $file = request()->file('file');
        $result = $this->Release->image($file);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 上传附加视频
     * @param Request $request
     * @return Json
     */
    public function video(Request $request): \think\response\Json
    {
        $file = request()->file('file');
        $result = $this->Release->video($file);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 延期
     * @param Request $request
     * @return Json
     */
    public function postpone(Request $request): \think\response\Json
    {
        $param = request()->only([
            'id',
            'trade_no',
        ], 'post');
        $param['status'] = input('post.status',false);
        $param['openid'] = $request->openid;
        try {
            validate(PropertyListingValidate::class)
                ->scene('postpone')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->Release->postpone($param);
        if ($result['success']) {
            return json(Response::success(
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 订单删除
     * @param Request $request
     * @return Json
     */
    public function deletePost(Request $request): \think\response\Json
    {
        $param = request()->only([
            'trade_no',
        ], 'post');
        $param['openid'] = $request->openid;
        try {
            validate(PropertyListingValidate::class)
                ->scene('delete')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->Release->deletePost($param);

        if ($result['success']) {
            return json(Response::success(
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }

    /**
     * 房源访客记录
     * @param Request $request
     * @return Json
     */
    public function visitor(Request $request): \think\response\Json
    {
        $param = request()->only([
            'property_listing_id',
        ], 'post');
        $param['openid'] = $request->openid;
        try {
            validate(PropertyListingValidate::class)
                ->scene('visitor')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->User->visitor($param);
        if ($result['success']) {
            return json(Response::success(
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }
    /**
     * 房源收藏记录
     * @param Request $request
     * @return Json
     */
    public function favorites(Request $request): \think\response\Json
    {
        $param = request()->only([
            'property_listing_id',
        ], 'post');
        $param['openid'] = $request->openid;
        try {
            validate(PropertyListingValidate::class)
                ->scene('favorites')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->User->favorites($param);
        if ($result['success']) {
            return json(Response::success(
                message: $result['msg']
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }
}