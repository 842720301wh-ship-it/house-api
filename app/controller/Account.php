<?php

namespace app\controller;

use app\common\Response;
use app\service\Account\Login;
use app\service\WeChat;
use think\Request;
use think\response\Json;

class Account
{
    protected Login $LoginService;
    protected WeChat $wechatService;

    public function __construct(Login $LoginService, WeChat $wechatService)
    {
        $this->LoginService = $LoginService;
        $this->wechatService = $wechatService;
    }

    /**
     * 微信小程序登录
     * @return Json
     */
    public function wxLogin(): \think\response\Json
    {
        $code = input('post.code');
        $nickname = input('post.nickname', '微信用户');
        $avatar = input('post.avatar', '');

        if (!$code) {
            return json(Response::error('code丢失'));
        }

        $res = $this->wechatService->codeToSession($code);

        if (!isset($res['openid'])) {
            return json(Response::wechatAuthFailed());
        }

        $result = $this->LoginService->loginOrRegister($res['openid'], $nickname, $avatar);

        if ($result['success']) {
            return json(Response::success(
                data: $result['data'],
                message: $result['msg']
            ));
        }

        return json(Response::error(
            message: "登录失败"
        ));

    }

    /**
     * 无感登录
     * @param Request $request
     * @return Json
     */
    public function checkToken(Request $request): \think\response\Json
    {
        $openid =$request->openid ?? null;
        $token =$request->userToken ?? null;

        $result = $this->LoginService->checkToken($openid,$token);

        if (!$result) {
            return json(Response::error('登录已过期'));
        }

        return json(Response::success(
            data: $result['data'],
            message: $result['msg']
        ));
    }

    /**
     * 退出登录
     * @return Json
     */
    public function logout(Request $request): \think\response\Json
    {
        $openid =$request->openid ?? null;
        $token =$request->userToken ?? null;

        if (!$openid || !$token) {
            return json(Response::error('参数缺失'));
        }

        $result = $this->LoginService->logout($openid, $token);

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