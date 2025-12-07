<?php

namespace app\middleware;

use app\model\Account;
use app\model\Admin;
use app\Request;
use think\facade\Cache;

class CheckToken
{
    /**
     *登录验证
     *
     */
    public function handle(\think\Request $request, \Closure $next)
    {
        header('Access-Control-Allow-Origin: *'); // 或指定域名
        header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, token');
        header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
        header('Access-Control-Allow-Credentials: true');

        $whiteList = [
            '/Baidu/getRegion',
            '/Account/wxLogin',
            '/PropertyListing/getHome'
        ];

        $path = $request->pathinfo();

        foreach ($whiteList as $white) {
            if (stripos($path, ltrim($white, '/')) === 0) {
                return $next($request);
            }
        }

        $token  = $request->header('token')?: $request->post('token');
        $openid = $request->header('openid')?: $request->post('openid');

        if (!$openid ) {
            return json(['statusCode' => 401, 'msg' => '请先登录!']);
        }
        if (!$token) {
            return json(['statusCode' => 401, 'msg' => '请先登录']);
        }

        $cacheToken =  Cache::store('redis')->get("user_token:{$openid}");

        if (!$cacheToken || $cacheToken != $token) {
            return json(['statusCode' => 401, 'msg' => 'Token 无效或已过期']);
        }

        $request->openid = $openid;
        $request->userToken = $token;

        return $next($request);
    }

}