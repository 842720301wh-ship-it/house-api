<?php
namespace app\common;

class Curl
{
    /**
     * 通用 GET 请求封装
     * @param string $url 请求地址
     * @param array $param 参数数组
     * @return array 返回结果（解析后的 JSON 或错误信息）
     */
    public static function get(string $url, array $param = []): array
    {
        $getUrl = $url . '?' . http_build_query($param);
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($curl, CURLOPT_URL, $getUrl);
        curl_setopt($curl, CURLOPT_TIMEOUT, 5);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HEADER, false);

        $data = curl_exec($curl);
        if ($data === false) {
            $error = curl_error($curl);
            curl_close($curl);
            return ['success' => false, 'msg' => "请求失败：$error"];
        }
        curl_close($curl);

        $result = json_decode($data, true);
        return $result ?? ['success' => false, 'msg' => '返回数据解析失败', 'raw' => $data];
    }

    /**
     * 通用 POST 请求封装
     * @param string $url 请求地址
     * @param array $param 参数数组
     * @return array
     */
    public static function post(string $url, array $param = []): array
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_TIMEOUT, 10);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($param));

        $data = curl_exec($curl);
        if ($data === false) {
            $error = curl_error($curl);
            curl_close($curl);
            return ['success' => false, 'msg' => "请求失败：$error"];
        }
        curl_close($curl);


        $result = json_decode($data, true);
        return $result ?? ['success' => false, 'msg' => '返回数据解析失败', 'raw' => $data];
    }
}
