<?php

namespace app\service\Account;

use app\model\Account;
use think\facade\Cache;
use think\facade\Log;

class Login
{
    protected int $expire = 7 * 24 * 3600; // 7天

    /**
     * 登录或注册用户
     */
    public function loginOrRegister($openid, $nickname = '', $avatar = ''): array
    {

        $user = Account::where('openid', $openid)->find();

        if (!$user) {
            $user = Account::create([
                'openid' => $openid,
                'create_time' => date('Y-m-d H:i:s'),
                'nickname' => $nickname,
                'avatar' => $avatar,
            ]);
        }

        $token = md5($openid . uniqid('', true));

        Cache::store('redis')->set("user_token:{$openid}", $token, $this->expire);

        $data = [
            'user_id' => $user->id,
            'nickname' => $user->nickname ?? '',
            'avatar' => $user->avatar ?? '',
            'openid' => $user->openid ?? '',
            'token'    => $token,
        ];

        if($data){
            return [
                'success' => true,
                'msg' => '登录成功',
                'data' => $data
            ];
        }else{
            return [
                'success' => false,
                'msg' => '登录失败',
            ];
        }
    }

    /**
     * 检查 Token
     */
    public function checkToken($openid, $token)
    {
        Cache::store('redis')->set("user_token:{$openid}", $token, $this->expire);

        $user = Account::where('openid', $openid)->find();

        $user['token'] = $token;

        return [
            'msg' => '登录成功',
            'data' => $user
        ];
    }

    /**
     * 退出登录
     */
    public function logout($openid, $token): array
    {
        Cache::store('redis')->delete("user_token:{$openid}");

        return [
            'success' => true,
            'msg' => '退出成功',
        ];
    }
}