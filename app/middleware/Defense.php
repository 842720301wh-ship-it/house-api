<?php

namespace app\middleware;

use think\facade\Cache;
use think\facade\Config;

class Defense
{
    /**
     * IP 防御
     */
    public function ipDefense(\think\Request $request, \Closure $next)
    {
        $ip = $request->ip();
        $path = $request->pathinfo();
        $now = time();

        // 从配置文件读取
        $window = Config::get('defense.window', 3600); // 滑动窗口
        $globalMax = Config::get('defense.global_max', 500); // 全局阈值
        $whiteList = Config::get('defense.white_list', []);
        $adminIps = Config::get('defense.admin_ips', []);
        $interfaceLimits = Config::get('defense.interface_limits', []);

        // 白名单接口，不限流
        foreach ($whiteList as $white) {
            if (stripos($path, ltrim($white, '/')) === 0) {
                return app(CheckToken::class)->handle($request, $next);
            }
        }

        // 管理员 IP 不限流
        if (in_array($ip, $adminIps)) {
            return app(CheckToken::class)->handle($request, $next);
        }

        // 单接口阈值
        $maxCount = $interfaceLimits[$path] ?? $interfaceLimits['*'] ?? 200;

        $redisKey = "ip_record:{$ip}";

        // 获取 IP 的所有接口记录
        $recordJson = Cache::store('redis')->get($redisKey);
        $record = $recordJson ? json_decode($recordJson, true) : [];
        if (!is_array($record)) $record = [];

        // 清理过期时间戳
        foreach ($record as $p => $tsArr) {
            if (!is_array($tsArr)) $tsArr = [];
            $record[$p] = array_filter($tsArr, fn($t) => $t > $now - $window);
        }

        // 当前接口加入访问
        $record[$path][] = $now;

        //  保存回 Redis
        Cache::store('redis')->set($redisKey, json_encode($record), $window);

        //  判断单接口阈值
        $currentCount = count($record[$path]);
        if ($currentCount > $maxCount) {
            return json([
                'statusCode' => 429,
                'msg' => "接口访问过于频繁，请稍后再试",
                'data' => ['ip' => $ip, 'path' => $path, 'count' => $currentCount, 'max' => $maxCount],
            ]);
        }

        //  计算全局总访问次数
        $totalCount = 0;
        foreach ($record as $tsArr) {
            if (!is_array($tsArr)) $tsArr = [];
            $totalCount += count($tsArr);
        }

        // 超过全局阈值拦截
        if ($totalCount > $globalMax) {
            return json([
                'statusCode' => 429,
                'msg' => "IP 总访问次数过于频繁，请稍后再试",
                'data' => ['ip' => $ip, 'total_count' => $totalCount, 'max' => $globalMax],
            ]);
        }

        //  放行
        return app(CheckToken::class)->handle($request, $next);
    }
}
