<?php
// config/defense.php

return [

    // 滑动窗口时间（秒），默认 1 小时
    'window' => 3600,

    // 全局总访问次数阈值（滑动窗口内）
    'global_max' => 500,

    // 白名单接口，不计数
    'white_list' => [
        'Account/checkToken',
        'PropertyListing/getorder',
        'PropertyListing/get',
        '/Pay/xPay'
    ],

    // 管理员 IP，不限流
    'admin_ips' => [
    ],

    // 单接口阈值配置
    'interface_limits' => [
        'Baidu/getRegion' => 5,
    ],

];
