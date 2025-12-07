<?php


return [
    // 默认磁盘
    'default' => env('filesystem.driver', 'local'),
    // 磁盘列表
    'disks'   => [
        'local'  => [
            'type' => 'local',
            'root' => app()->getRuntimePath() . 'storage',  // runtime目录
        ],
        'public' => [
            // 磁盘类型
            'type'       => 'local',
            // 磁盘路径 (将文件存储到 public/uploads)
            'root'       =>dirname(app()->getRootPath()) . '/uploads',
            // 外部访问URL路径
            'url'        =>  env('APP_URL.test', '').'/uploads',
            // 可见性
            'visibility' => 'public',
        ],
        // 更多的磁盘配置信息
    ],
];
