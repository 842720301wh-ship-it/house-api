<?php

namespace app\common;

class Response
{
    // 成功状态码
    const SUCCESS = 200;

    // 客户端错误
    const BAD_REQUEST = 400;
    const UNAUTHORIZED = 401;
    const FORBIDDEN = 403;
    const NOT_FOUND = 404;

    // 服务器错误
    const INTERNAL_ERROR = 500;
    const SERVICE_UNAVAILABLE = 503;

    // 业务错误码
    const WECHAT_AUTH_FAILED = 1001;
    const CONTENT_SECURITY_FAILED = 1002;
    const PERMISSION_DENIED = 1003;
    const DATA_VALIDATION_FAILED = 1004;

    /**
     * 成功响应
     *
     * @param string $message 提示信息
     * @param null $data 当前页数据
     */
    public static function success($data = null, string $message = '操作成功', int $code = self::SUCCESS): array
    {
        return [
            'statusCode' => $code,
            'msg' => $message,
            'data' => $data
        ];
    }

    /**
     * 分页成功响应
     *
     * @param null $data 当前页数据
     * @param int $total 数据总条数
     * @param string $message 提示信息
     */
    public static function pageSuccess( int $total , string $message = '查询成功',$data = null,): array
    {
        return [
            'statusCode' => self::SUCCESS,
            'msg'        => $message,
            'data'       => $data,
            'total'      => $total,
        ];
    }

    /**
     * 错误响应
     *
     * @param string $message 提示信息
     */
    public static function error(string $message = '操作失败', int $code = self::INTERNAL_ERROR, $data = null): array
    {
        return [
            'statusCode' => $code,
            'msg' => $message,
            'data' => $data
        ];
    }

    /**
     * 参数错误响应
     * @param string $message 提示信息
     */
    public static function paramError(string $message = '参数错误'): array
    {
        return self::error($message, self::BAD_REQUEST);
    }

    /**
     * 权限不足响应
     * @param string $message 提示信息
     */
    public static function permissionDenied(string $message = '权限不足'): array
    {
        return self::error($message, self::FORBIDDEN);
    }

    /**
     * 未找到资源响应
     * @param string $message 提示信息
     */
    public static function notFound(string $message = '资源未找到'): array
    {
        return self::error($message, self::NOT_FOUND);
    }

    /**
     * 微信认证失败
     * @param string $message 提示信息
     */
    public static function wechatAuthFailed(string $message = '微信认证失败'): array
    {
        return self::error($message, self::WECHAT_AUTH_FAILED);
    }

    /**
     * 内容安全检测失败
     * @param string $message 提示信息
     */
    public static function contentSecurityFailed(string $message = '内容包含违规信息'): array
    {
        return self::error($message, self::CONTENT_SECURITY_FAILED);
    }

}