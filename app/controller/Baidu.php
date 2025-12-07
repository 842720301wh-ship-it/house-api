<?php

namespace app\controller;

use app\common\Response;
use app\validate\Baidu as BaiduValidate;
use think\exception\ValidateException;
use think\response\Json;
use app\service\BaiDu as BaiduService;


class Baidu
{
    protected BaiduService $baiduService;
    protected string $ak;


    public function __construct(BaiduService $baiduService)
    {
        $this->baiduService  = $baiduService;
        $this->ak  = env('baidu.AK', '');
    }

    /**
     * 获取行政区域
     * @return Json
     */
    public function getRegion(): \think\response\Json
    {
        $keyword = input('post.keyword', '全国');
        $sub_admin = input('post.sub_admin', '1');

        $param = [
            'keyword'     => $keyword,
            'sub_admin' => $sub_admin,
            'ak'       => $this->ak,
        ];
        try {
            validate(BaiduValidate::class)
                ->scene('get')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->baiduService->get($param);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg'],
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }
    /**
     * 地点检索
     * @return Json
     */
    public function region(): \think\response\Json
    {
        $query = input('post.query', '');
        $region= input('post.region', '');
        $param = [
            'query'         => $query,
            'region'        => $region,
            'ak'            => $this->ak,
            'region_limit'  => true,
         ];
        try {
            validate(BaiduValidate::class)
                ->scene('region')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }
        $result = $this->baiduService->region($param);
        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg'],
            ));
        }
        return json(Response::error(
            message: $result['msg']
        ));
    }
}