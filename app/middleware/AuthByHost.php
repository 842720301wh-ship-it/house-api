<?php
declare (strict_types = 1);

namespace app\middleware;

use app\Request;
use Closure;

class AuthByHost
{
    /**
     *接口验证
     *
     * @param Request $request
     * @param Closure $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $host = $request->host();

        $skipAuth = env('auth.skip_auth', false);
        $mockUserEnabled = env('auth.mock_user', true);

        // 判断是否启用本地调试模式
        $isLocalHost = str_contains($host, '192.168.188.69') || str_contains($host, 'localhost');

        if ($isLocalHost && $mockUserEnabled && !$skipAuth) {
            // 注入模拟用户数据
            $request->openid        = env('auth.mock_openid', '');
            $request->userPermission = env('auth.mock_permission', '');
            $request->userToken     = env('auth.mock_token', '');
            return $next($request);
        }

        // 如果 skip_auth 开启（无论本地还是线上）也注入模拟用户
        if ($skipAuth) {
            $request->openid        = env('auth.mock_openid', '');
            $request->userPermission = env('auth.mock_permission', '');
            $request->userToken     = env('auth.mock_token', '');
            return $next($request);
        }

        return app(Defense::class)->ipDefense($request, $next);


    }
}
