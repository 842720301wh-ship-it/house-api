<?php

namespace app\controller;
use app\common\Response;
use app\service\Pay\xpay as XpayService;
use app\validate\Pay as PayValidate;
use think\exception\ValidateException;
use think\Request;
use think\response\Json;

class Pay
{
    protected XpayService $XpayService;
    protected string $pid;

    protected string $key;



    public function __construct(XpayService $XpayService)
    {
        $this->XpayService  = $XpayService;
        $this->pid  = env('pay.pid', '');
        $this->key  = env('pay.key', '');

    }

    /**
     * 码支付
     * @param Request $request
     * @return Json
     */
    public function xPay(Request $request): Json
    {
        $param = request()->only([
            'name',
            'money',
        ], 'post');
        $param['out_trade_no']= date('YmdHis') . mt_rand(100, 999);
//        $param['notify_url']= ' https://xxx.com/xpay/epay';
        $param['type']= 'wxpay';
        $param['openid']= $request->openid;
        $param['pid']= $this->pid;
        $param['key']= $this->key;


        $param['sign'] = $this->XpayService->getSign($param,$this->key);


        try {
            validate(PayValidate::class)
                ->scene('pay')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }

        $result = $this->XpayService->xpay($param);

        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg'],
            ));
        }

        return json(Response::error(
            message: $result['msg'],
            data: $result['data'],
        ));
    }

    /**
     * 码支付验证
     * @param Request $request
     * @return Json
     */
    public function check(Request $request): Json
    {
        $param['openid']= $request->openid;
        $param['pid']= $this->pid;
        $param['key']= $this->key;
        $param['act']= 'order';

        try {
            validate(PayValidate::class)
                ->scene('check')
                ->check($param);
        } catch (ValidateException $e) {
            return json(Response::error(
                message: $e->getError()
            ));
        }

        $result = $this->XpayService->checkxpay($param);

        if ($result['success']) {
            return json(Response::success(
                message: $result['msg'],
            ));
        }

        return json(Response::error(
            message: $result['msg'],
        ));
    }
}