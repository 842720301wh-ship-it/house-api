<?php

namespace app\service;

use app\common\Curl;

class BaiDu
{
    public function get(array $param): array
    {
        $url = 'https://api.map.baidu.com/api_region_search/v1/';

        $result = Curl::get($url, $param);

        if (isset($result['status']) && (int)$result['status'] === 0) {
            return ['success' => true, 'msg' => '请求成功', 'data' => $result];
        }

        return [
            'success' => false,
            'msg' => $result['message'] ?? '请求失败',
            'data' => $result
        ];
    }

    public function region(array $param): array
    {
        $url = 'https://api.map.baidu.com/place/v3/suggestion';
        $result = Curl::get($url, $param);

        if (isset($result['status']) && (int)$result['status'] === 0) {
            if (isset($result['results']) && is_array($result['results'])) {
                $region = $param['region'] ?? '';
                $result['results'] = array_filter($result['results'], function($item) use ($region) {
                    return isset($item['city']) && $item['city'] === $region;
                });
                $result['results'] = array_values($result['results']);
            }

            return [
                'success' => true,
                'msg' => '请求成功',
                'data' => $result
            ];
        }

        return [
            'success' => false,
            'msg' => $result['message'] ?? '请求失败',
            'data' => $result
        ];
    }
}