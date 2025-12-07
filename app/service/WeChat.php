<?php
namespace app\service;

class WeChat
{
    protected string $appid;
    protected string $secret;
    public function __construct()
    {
        $this->appid  = env('wechat.APPID', '');
        $this->secret = env('wechat.SECRET', '');
    }

    /**
     * 通过 code 换取 session_key 和 openid
     */
    public function codeToSession(string $code): array
    {
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$this->appid}&secret={$this->secret}&js_code={$code}&grant_type=authorization_code";

        $response = file_get_contents($url);
        if ($response === false) {
            // 这里你可以抛异常或者返回错误
            return ['error' => '请求微信接口失败'];
        }

        return json_decode($response, true);
    }
}
