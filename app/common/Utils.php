<?php
namespace app\common;

class Utils
{

     /**
     * 时间格式化
     * 使用方法:
     * use app\common\Utils;
     *
     * echo Utils::formatCreateTime('2025-08-12 08:00:00');
     */
    public static function formatCreateTime($create_time)
    {
        $createTimestamp = strtotime($create_time);
        $nowTimestamp = time();
        $diffSeconds = $nowTimestamp - $createTimestamp;

        if ($diffSeconds < 60 * 60) {
            $minutes = floor($diffSeconds / 60);
            return $minutes <= 0 ? '刚刚' : $minutes . ' 分钟前';
        } elseif ($diffSeconds < 24 * 60 * 60) {
            $hours = floor($diffSeconds / 3600);
            return $hours . ' 小时前';
        } else {
            $nowYear = date('Y');
            $postYear = date('Y', $createTimestamp);
            if ($nowYear === $postYear) {
                return date('m月d日', $createTimestamp);
            } else {
                return date('Y-m-d', $createTimestamp);
            }
        }
    }
}
