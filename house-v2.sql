-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2026-04-30 18:52:11
-- 服务器版本： 5.7.44-log
-- PHP 版本： 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `house-v2`
--

-- --------------------------------------------------------

--
-- 表的结构 `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL COMMENT 'id',
  `openid` varchar(225) NOT NULL COMMENT '账号id',
  `nickname` varchar(225) NOT NULL COMMENT '昵称',
  `avatar` varchar(225) NOT NULL COMMENT '头像',
  `create_time` datetime NOT NULL COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `account`
--

INSERT INTO `account` (`id`, `openid`, `nickname`, `avatar`, `create_time`) VALUES
(1, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '微信用户', '', '2026-02-10 15:59:15');

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

CREATE TABLE `admin` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `login_failure` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `last_login_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐（废弃待删）',
  `motto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态:enable=启用,disable=禁用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `admin`
--

INSERT INTO `admin` (`id`, `username`, `nickname`, `avatar`, `email`, `mobile`, `login_failure`, `last_login_time`, `last_login_ip`, `password`, `salt`, `motto`, `status`, `update_time`, `create_time`) VALUES
(1, 'admin', 'Admin', '', 'admin@buildadmin.com', '18888888888', 0, 1771750037, '124.240.42.38', '$2y$10$d5GMSUKd3fBWpUjrdROAI.VLCS3i6nDYTHBYGOqOjY2NBjKvi9swq', '', '', 'enable', 1771750037, 1770530411),
(2, 'one', 'One', '', '', '', 0, 1771758086, '124.240.42.38', '$2y$10$elLV/LVR14DAsbn5zUO4S.lwL.7SYgxeXxcSsGOQ.VQApbHsWAyOW', '', '', 'enable', 1771758086, 1771749965);

-- --------------------------------------------------------

--
-- 表的结构 `admin_group`
--

CREATE TABLE `admin_group` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级分组',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限规则ID',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理分组表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `admin_group`
--

INSERT INTO `admin_group` (`id`, `pid`, `name`, `rules`, `status`, `update_time`, `create_time`) VALUES
(1, 0, '超级管理组', '*', 1, 1770530411, 1770530411),
(2, 1, '一级管理员', '1,89,4,9,13,18,17,16,15,14,19,20,97,127,132,131,130,129,128,102,101,100,99,98,103,121,126,125,124,123,122,109,114,113,112,111,110,115,120,119,118,117,116,108,107,106,105,104,133,134,139,138,137,136,135,140,145,144,143,142,141,146,151,150,149,148,147,152,157,156,155,154,153,171,176,175,174,173,172,158,163,162,161,160,159,77,47,46,48,51,50,49,52,54,53,55,56,60,59,58,57,61,65,64,63,62,66,70,69,68,67,71,75,74,73,72,2,3,8,44,45', 1, 1771750027, 1770530411),
(3, 2, '二级管理员', '21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43', 1, 1770530411, 1770530411),
(4, 3, '三级管理员', '19,20,128,122,110,116,135,141,147,153,172,159,52,54,53,2,97,127,103,121,109,115,133,134,140,146,152,171,158,44', 1, 1770710351, 1770530411);

-- --------------------------------------------------------

--
-- 表的结构 `admin_group_access`
--

CREATE TABLE `admin_group_access` (
  `uid` int(11) UNSIGNED NOT NULL COMMENT '管理员ID',
  `group_id` int(11) UNSIGNED NOT NULL COMMENT '分组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理分组映射表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `admin_group_access`
--

INSERT INTO `admin_group_access` (`uid`, `group_id`) VALUES
(1, 1),
(2, 2),
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- 表的结构 `admin_log`
--

CREATE TABLE `admin_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `url` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作Url',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT '请求数据',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员日志表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `admin_log`
--

INSERT INTO `admin_log` (`id`, `admin_id`, `username`, `url`, `title`, `data`, `ip`, `useragent`, `create_time`) VALUES
(1, 1, 'admin', '/house-admin-v2/public/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"1\",\"captchaId\":\"60d06aaa-7cde-4a43-841a-71027d6568b4\",\"captchaInfo\":\"317,101-138,138;350;200\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770531915),
(2, 1, 'admin', '/house-admin-v2/public/admin/module/install', '安装模块', '{\"uid\":\"dataexport\",\"update\":\"\",\"version\":\"v1.0.9\",\"orderId\":\"33013\",\"token\":\"***\",\"extend\":[]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770531937),
(3, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"account\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532042),
(4, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"account\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/account\",\"controllerFile\":\"app\\/admin\\/controller\\/Account.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532089),
(5, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"account\",\"comment\":\"\\u8d26\\u53f7\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"nickname\",\"avatar\"],\"columnFields\":[\"id\",\"openid\",\"nickname\",\"avatar\",\"create_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"account\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Account.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Account.php\",\"validateFile\":\"app\\/admin\\/validate\\/Account.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/account\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8d26\\u53f7id\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"nickname\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6635\\u79f0\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5934\\u50cf\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"create_time\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6ce8\\u518c\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532089),
(6, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"dynamic\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532125),
(7, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"dynamic\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\",\"controllerFile\":\"app\\/admin\\/controller\\/Dynamic.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532182),
(8, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"dynamic\",\"comment\":\"\\u52a8\\u6001\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"text\",\"telephone\",\"area\",\"address\",\"lat\",\"lng\"],\"columnFields\":[\"id\",\"create_time\",\"openid\",\"telephone\",\"area\",\"address\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Dynamic.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Dynamic.php\",\"validateFile\":\"app\\/admin\\/validate\\/Dynamic.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u8005\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"text\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6587\\u672c\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"area\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4f4d\\u7f6e\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"address\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u4f4d\\u7f6e\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7eac\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7ecf\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532182),
(9, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"dynamic_image\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532196),
(10, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"dynamic_image\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/image\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Image.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532239),
(11, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"dynamic_image\",\"comment\":\"\\u52a8\\u6001\\u56fe\\u7247\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"dynamic_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"dynamic_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic_image\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/dynamic\\/Image.php\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Image.php\",\"validateFile\":\"app\\/admin\\/validate\\/dynamic\\/Image.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/image\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"dynamic_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e3b\\u8868id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"dynamic\",\"remote-controller\":\"app\\/admin\\/controller\\/Dynamic.php\",\"remote-model\":\"app\\/admin\\/model\\/Dynamic.php\",\"relation-fields\":\"area,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8def\\u5f84\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6b21\\u5e8f\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532240),
(12, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"dynamic_video\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532299),
(13, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"dynamic_video\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/video\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Video.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532435),
(14, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"dynamic_video\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/video\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Video.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532460),
(15, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"dynamic_video\",\"comment\":\"\\u52a8\\u6001\\u89c6\\u9891\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"dynamic_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"dynamic_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic_video\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/dynamic\\/Video.php\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Video.php\",\"validateFile\":\"app\\/admin\\/validate\\/dynamic\\/Video.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/video\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"dynamic_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e3b\\u8868id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"dynamic\",\"remote-controller\":\"app\\/admin\\/controller\\/Dynamic.php\",\"remote-model\":\"app\\/admin\\/model\\/Dynamic.php\",\"relation-fields\":\"area,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8def\\u5f84\",\"designType\":\"file\",\"table\":{\"render\":\"url\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"file-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6b21\\u5e8f\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770532468),
(16, 1, 'admin', '/house-admin-v2/public/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"1\",\"captchaId\":\"6a515c7e-3a2e-4631-8742-76feb4fc5b44\",\"captchaInfo\":\"123,69-187,164;350;200\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534476),
(17, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{\"id\":\"2\",\"type\":\"\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534487),
(18, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"dynamic\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/dynamic\",\"controllerFile\":\"app\\/admin\\/controller\\/Dynamic.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534499),
(19, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"log\",\"table\":{\"name\":\"dynamic\",\"comment\":\"\\u52a8\\u6001\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"text\",\"telephone\",\"area\",\"address\",\"lat\",\"lng\"],\"columnFields\":[\"id\",\"create_time\",\"openid\",\"telephone\",\"area\",\"address\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Dynamic.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Dynamic.php\",\"validateFile\":\"app\\/admin\\/validate\\/Dynamic.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/dynamic\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u8005\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"text\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6587\\u672c\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"area\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4f4d\\u7f6e\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"address\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u4f4d\\u7f6e\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7eac\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7ecf\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534501),
(20, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{\"id\":\"1\",\"type\":\"\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534520),
(21, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"account\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/account\\/account\",\"controllerFile\":\"app\\/admin\\/controller\\/Account.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534528),
(22, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"log\",\"table\":{\"name\":\"account\",\"comment\":\"\\u8d26\\u53f7\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"nickname\",\"avatar\"],\"columnFields\":[\"id\",\"openid\",\"nickname\",\"avatar\",\"create_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"account\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Account.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Account.php\",\"validateFile\":\"app\\/admin\\/validate\\/Account.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/account\\/account\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8d26\\u53f7id\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"nickname\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6635\\u79f0\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5934\\u50cf\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"create_time\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6ce8\\u518c\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534529),
(23, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"property_listing\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534543),
(24, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534601),
(25, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"property_listing\",\"comment\":\"\\u623f\\u6e90\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"city\",\"address\",\"lat\",\"lng\",\"rentType\",\"house\",\"area\",\"money\",\"introduction\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"columnFields\":[\"id\",\"openid\",\"city\",\"address\",\"rentType\",\"house\",\"area\",\"money\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/Listing.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u4eba\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"city\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u57ce\\u5e02\",\"designType\":\"city\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"address\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7eac\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7ecf\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"rentType\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u51fa\\u79df\\u65b9\\u5f0f\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"house\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6237\\u578b\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"area\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u9762\\u79ef\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"money\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4ef7\\u683c\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"introduction\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u4ecb\\u7ecd\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"type\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7c7b\\u578b\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e0a\\u67b6\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8ba2\\u5355\\u53f7\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534601),
(26, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"property_listing_image\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534615),
(27, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing_image\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/image\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Image.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534664),
(28, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"property_listing_image\",\"comment\":\"\\u623f\\u6e90\\u56fe\\u7247\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"property_listing_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_image\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Image.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Image.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Image.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/image\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7236\\u8868id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6587\\u4ef6\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6b21\\u5e8f\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534664),
(29, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{\"id\":\"7\",\"type\":\"\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534677),
(30, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534688),
(31, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"log\",\"table\":{\"name\":\"property_listing\",\"comment\":\"\\u623f\\u6e90\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"city\",\"address\",\"lat\",\"lng\",\"rentType\",\"house\",\"area\",\"money\",\"introduction\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"columnFields\":[\"id\",\"openid\",\"city\",\"address\",\"rentType\",\"house\",\"area\",\"money\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/Listing.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u4eba\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"city\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u57ce\\u5e02\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"false\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"address\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7eac\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7ecf\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"rentType\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u51fa\\u79df\\u65b9\\u5f0f\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"house\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6237\\u578b\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"area\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u9762\\u79ef\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"money\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4ef7\\u683c\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"introduction\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u4ecb\\u7ecd\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"type\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7c7b\\u578b\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e0a\\u67b6\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8ba2\\u5355\\u53f7\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534689),
(32, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"property_listing_video\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534701),
(33, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing_video\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/video\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Video.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534732),
(34, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"property_listing_video\",\"comment\":\"\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"property_listing_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_video\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Video.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Video.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Video.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/video\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7236\\u8868id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6587\\u4ef6\",\"designType\":\"file\",\"table\":{\"render\":\"url\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"file-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6b21\\u5e8f\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534732);
INSERT INTO `admin_log` (`id`, `admin_id`, `username`, `url`, `title`, `data`, `ip`, `useragent`, `create_time`) VALUES
(35, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/del?ids[]=76', '菜单规则管理-删除', '{\"ids\":[\"76\"]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534757),
(36, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"133\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u623f\\u6e90\\u7ba1\\u7406\",\"name\":\"propertylisting\",\"path\":\"propertylisting\",\"icon\":\"fa fa-circle-o\",\"menu_type\":null,\"url\":\"\",\"component\":\"\",\"keepalive\":\"0\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1770534601\",\"create_time\":\"1770534601\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534777),
(37, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"146\",\"pid\":\"133\",\"type\":\"menu\",\"title\":\"\\u623f\\u6e90\\u89c6\\u9891\\u7ba1\\u7406\",\"name\":\"propertylisting\\/video\",\"path\":\"propertylisting\\/video\",\"icon\":\"fa fa-circle-o\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/propertylisting\\/video\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1770534732\",\"create_time\":\"1770534732\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534793),
(38, 1, 'admin', '/house-admin-v2/public/admin/routine.dataexport/add', '数据导出管理-添加', '{\"name\":\"1\",\"main_table\":\"dynamic\",\"field_config\":[{\"name\":\"id\",\"discern\":\"int\",\"title\":\"\\u7d22\\u5f15\",\"comment\":\"\"},{\"name\":\"openid\",\"discern\":\"text\",\"title\":\"\\u53d1\\u5e03\\u8005\",\"comment\":\"\"},{\"name\":\"text\",\"discern\":\"text\",\"title\":\"\\u6587\\u672c\",\"comment\":\"\"},{\"name\":\"telephone\",\"discern\":\"text\",\"title\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\",\"comment\":\"\"},{\"name\":\"area\",\"discern\":\"text\",\"title\":\"\\u4f4d\\u7f6e\",\"comment\":\"\"},{\"name\":\"address\",\"discern\":\"text\",\"title\":\"\\u8be6\\u7ec6\\u4f4d\\u7f6e\",\"comment\":\"\"},{\"name\":\"lat\",\"discern\":\"text\",\"title\":\"\\u7eac\\u5ea6\",\"comment\":\"\"},{\"name\":\"lng\",\"discern\":\"text\",\"title\":\"\\u7ecf\\u5ea6\",\"comment\":\"\"},{\"name\":\"create_time\",\"discern\":\"time\",\"title\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"comment\":\"\"}],\"join_table\":[],\"where_field\":[],\"xls_max_number\":\"10000\",\"concurrent_create_xls\":\"3\",\"memory_limit\":\"128\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770534816),
(39, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"property_listing_order\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535008),
(40, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing_order\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/order\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Order.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535094),
(41, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"property_listing_order\",\"comment\":\"\\u623f\\u6e90\\u8d26\\u5355\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"type\",\"trade_no\",\"openid\",\"status\"],\"columnFields\":[\"id\",\"property_listing_id\",\"trade_no\",\"openid\",\"status\",\"create_time\",\"type\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_order\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Order.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Order.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Order.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/order\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e3b\\u8868id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"type\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5546\\u54c1\\u540d\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8ba2\\u5355\\u53f7\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8d26\\u53f7\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u652f\\u4ed8\\u72b6\\u6001\",\"designType\":\"switch\",\"table\":{\"render\":\"switch\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e0b\\u5355\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535095),
(42, 1, 'admin', '/house-admin-v2/public/admin/property.listing.Order/edit', '未知(edit)', '{\"id\":\"49\",\"status\":\"0\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535105),
(43, 1, 'admin', '/house-admin-v2/public/admin/property.listing.Order/edit', '未知(edit)', '{\"id\":\"49\",\"status\":\"1\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535106),
(44, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{\"id\":\"9\",\"type\":\"\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535141),
(45, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535150),
(46, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"log\",\"table\":{\"name\":\"property_listing\",\"comment\":\"\\u623f\\u6e90\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"city\",\"address\",\"lat\",\"lng\",\"rentType\",\"house\",\"area\",\"money\",\"introduction\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"columnFields\":[\"id\",\"openid\",\"city\",\"address\",\"rentType\",\"house\",\"area\",\"money\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/Listing.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u53d1\\u5e03\\u4eba\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"city\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u57ce\\u5e02\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"false\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"address\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7eac\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7ecf\\u5ea6\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"rentType\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u51fa\\u79df\\u65b9\\u5f0f\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"house\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6237\\u578b\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"area\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u9762\\u79ef\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"money\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4ef7\\u683c\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"introduction\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8be6\\u7ec6\\u4ecb\\u7ecd\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"type\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7c7b\\u578b\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u4e0a\\u67b6\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8ba2\\u5355\\u53f7\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}}]}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535151),
(47, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"97\",\"target\":\"55\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535353),
(48, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"97\",\"target\":\"21\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535357),
(49, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"103\",\"target\":\"21\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535360),
(50, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"133\",\"target\":\"21\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535364),
(51, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"97\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u8d26\\u53f7\\u7ba1\\u7406\",\"name\":\"account\",\"path\":\"account\",\"icon\":\"fa fa-circle-o\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/account\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"95\",\"status\":\"1\",\"update_time\":\"1770535357\",\"create_time\":\"1770532089\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535397),
(52, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"103\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u52a8\\u6001\\u7ba1\\u7406\",\"name\":\"dynamic\",\"path\":\"dynamic\",\"icon\":\"fa fa-circle-o\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/dynamic\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"94\",\"status\":\"1\",\"update_time\":\"1770535360\",\"create_time\":\"1770532182\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535401),
(53, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"121\",\"target\":\"109\",\"direction\":\"down\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535425),
(54, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"121\",\"target\":\"115\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535436),
(55, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"109\",\"target\":\"115\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535441),
(56, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"134\",\"target\":\"152\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535454),
(57, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"152\",\"target\":\"140\",\"direction\":\"down\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535458),
(58, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/sortable', '菜单规则管理-快速排序', '{\"move\":\"140\",\"target\":\"146\",\"direction\":\"up\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535460),
(59, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"97\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u8d26\\u53f7\\u7ba1\\u7406\",\"name\":\"account\",\"path\":\"account\",\"icon\":\"el-icon-UserFilled\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/account\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"226\",\"status\":\"1\",\"update_time\":\"1770535397\",\"create_time\":\"1770532089\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535482),
(60, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"103\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u52a8\\u6001\\u7ba1\\u7406\",\"name\":\"dynamic\",\"path\":\"dynamic\",\"icon\":\"el-icon-Comment\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/dynamic\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"225\",\"status\":\"1\",\"update_time\":\"1770535401\",\"create_time\":\"1770532182\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535504),
(61, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"133\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u623f\\u6e90\\u7ba1\\u7406\",\"name\":\"propertylisting\",\"path\":\"propertylisting\",\"icon\":\"el-icon-HomeFilled\",\"menu_type\":null,\"url\":\"\",\"component\":\"\",\"keepalive\":\"0\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"224\",\"status\":\"1\",\"update_time\":\"1770535364\",\"create_time\":\"1770534601\"}', '192.168.93.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770535514),
(62, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"property_listing_visitor\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709793),
(63, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing_visitor\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/visitor\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Visitor.php\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709850),
(64, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"property_listing_visitor\",\"comment\":\"\\u623f\\u6e90\\u8bbf\\u5ba2\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"openid\"],\"columnFields\":[\"id\",\"property_listing_id\",\"create_time\",\"openid\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_visitor\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Visitor.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Visitor.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Visitor.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/visitor\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u623f\\u6e90id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8bbf\\u5ba2\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6d4f\\u89c8\\u65f6\\u95f4\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709851),
(65, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"property_listing_favorites\",\"sql\":\"\",\"connection\":\"mysql\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709897),
(66, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing_favorites\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/property\\/listingfavorites\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Favorites.php\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709948),
(67, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"property_listing_favorites\",\"comment\":\"\\u623f\\u6e90\\u6536\\u85cf\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"openid\"],\"columnFields\":[\"id\",\"property_listing_id\",\"openid\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_favorites\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Favorites.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Favorites.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Favorites.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/property\\/listingfavorites\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u623f\\u6e90id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7528\\u6237\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}}]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709948),
(68, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{\"id\":\"14\",\"type\":\"\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709977),
(69, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"property_listing_favorites\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/favorites\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Favorites.php\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709987),
(70, 1, 'admin', '/house-admin-v2/public/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"log\",\"table\":{\"name\":\"property_listing_favorites\",\"comment\":\"\\u623f\\u6e90\\u6536\\u85cf\\u7ba1\\u7406\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"openid\"],\"columnFields\":[\"id\",\"property_listing_id\",\"openid\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_favorites\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Favorites.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Favorites.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Favorites.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/favorites\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"},\"fields\":[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7d22\\u5f15\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u623f\\u6e90id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u7528\\u6237\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}}]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770709989),
(71, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/del?ids[]=164', '菜单规则管理-删除', '{\"ids\":[\"164\"]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710010),
(72, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/del?ids[]=169&ids[]=168&ids[]=167&ids[]=166', '菜单规则管理-删除', '{\"ids\":[\"169\",\"168\",\"167\",\"166\"]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710025),
(73, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/del?ids[]=170&ids[]=165', '菜单规则管理-删除', '{\"ids\":[\"170\",\"165\"]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710032),
(74, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/del?ids[]=164', '菜单规则管理-删除', '{\"ids\":[\"164\"]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710038),
(75, 1, 'admin', '/house-admin-v2/public/admin/security.DataRecycle/edit', '数据回收规则管理-编辑', '{\"id\":\"5\",\"name\":\"\\u7528\\u6237\",\"controller\":\"Account.php\",\"controller_as\":\"user\\/user\",\"data_table\":\"account\",\"connection\":\"mysql\",\"primary_key\":\"id\",\"status\":\"1\",\"update_time\":\"1770530411\",\"create_time\":\"1770530411\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710138),
(76, 1, 'admin', '/house-admin-v2/public/admin/security.SensitiveData/edit', '敏感字段规则管理-编辑', '{\"id\":\"2\",\"name\":\"\\u7528\\u6237\\u6570\\u636e\",\"controller\":\"Account.php\",\"controller_as\":\"user\\/user\",\"data_table\":\"account\",\"connection\":\"mysql\",\"primary_key\":\"id\",\"data_fields\":[\"openid\"],\"status\":\"1\",\"update_time\":\"1770530411\",\"create_time\":\"1770530411\",\"fields\":[{\"name\":\"openid\",\"value\":\"\\u8d26\\u53f7id\"}]}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710200),
(77, 1, 'admin', '/house-admin-v2/public/admin/ajax/upload?uuid=89bb72e7-e70d-4ee2-9a07-5b7a7ed1624f', '上传文件', '{\"uuid\":\"89bb72e7-e70d-4ee2-9a07-5b7a7ed1624f\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710271),
(78, 1, 'admin', '/house-admin-v2/public/admin/auth.Group/edit', '角色组管理-编辑', '{\"id\":\"4\",\"pid\":\"3\",\"name\":\"\\u4e09\\u7ea7\\u7ba1\\u7406\\u5458\",\"rules\":[\"19\",\"20\",\"128\",\"122\",\"110\",\"116\",\"135\",\"141\",\"147\",\"153\",\"172\",\"159\",\"52\",\"54\",\"53\",\"2\",\"97\",\"127\",\"103\",\"121\",\"109\",\"115\",\"133\",\"134\",\"140\",\"146\",\"152\",\"171\",\"158\",\"44\"],\"status\":\"1\",\"update_time\":\"1770530411\",\"create_time\":\"1770530411\"}', '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770710351),
(79, 1, 'admin', '/house-admin-v2/public/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"1\",\"captchaId\":\"bbce6048-721f-4cd2-8c8f-e58100feea1f\",\"captchaInfo\":\"40,76-82,120;350;200\"}', '192.168.93.107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 1770964228),
(80, 0, 'admin', '/house-admin-v2/public/admin/Index/login', '未知(login)', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"8b699197-8397-4430-964d-abc94b8c1756\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771662845),
(81, 0, 'admin', '/house-admin-v2/public/admin/Index/login', '未知(login)', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"8b699197-8397-4430-964d-abc94b8c1756\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771662868),
(82, 0, 'admin', '/house-admin-v2/public/admin/Index/login', '未知(login)', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"8b699197-8397-4430-964d-abc94b8c1756\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771662909),
(83, 0, 'admin', '/house-admin-v2/public/admin/Index/login', '未知(login)', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"f01470bf-a8b7-4d16-8cb5-a3dbccc4b384\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771662919),
(84, 1, 'admin', '/house-admin-v2/public/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"f01470bf-a8b7-4d16-8cb5-a3dbccc4b384\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771662931),
(85, 1, 'admin', '/house-admin-v2/public/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"d4aa5278-9a5a-4a78-864c-9c4c02a90405\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771663284),
(86, 1, 'admin', '/house-admin-v2/public/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"134\",\"pid\":\"133\",\"type\":\"menu\",\"title\":\"\\u623f\\u6e90\\u7ba1\\u7406\",\"name\":\"propertylisting\\/listing\",\"path\":\"propertylisting\\/listing\",\"icon\":\"el-icon-HomeFilled\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/propertylisting\\/listing\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"122\",\"status\":\"1\",\"update_time\":\"1770535454\",\"create_time\":\"1770534601\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771749832),
(87, 1, 'admin', '/house-admin-v2/public/admin/auth.Admin/add', '管理员管理-添加', '{\"status\":\"enable\",\"group_arr\":[\"2\"],\"username\":\"one\",\"nickname\":\"One\",\"password\":\"***\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771749965),
(88, 1, 'admin', '/house-admin-v2/public/admin/auth.Group/edit', '角色组管理-编辑', '{\"id\":\"2\",\"pid\":\"1\",\"name\":\"\\u4e00\\u7ea7\\u7ba1\\u7406\\u5458\",\"rules\":[\"1\",\"89\",\"4\",\"9\",\"13\",\"18\",\"17\",\"16\",\"15\",\"14\",\"19\",\"20\",\"97\",\"127\",\"132\",\"131\",\"130\",\"129\",\"128\",\"102\",\"101\",\"100\",\"99\",\"98\",\"103\",\"121\",\"126\",\"125\",\"124\",\"123\",\"122\",\"109\",\"114\",\"113\",\"112\",\"111\",\"110\",\"115\",\"120\",\"119\",\"118\",\"117\",\"116\",\"108\",\"107\",\"106\",\"105\",\"104\",\"133\",\"134\",\"139\",\"138\",\"137\",\"136\",\"135\",\"140\",\"145\",\"144\",\"143\",\"142\",\"141\",\"146\",\"151\",\"150\",\"149\",\"148\",\"147\",\"152\",\"157\",\"156\",\"155\",\"154\",\"153\",\"171\",\"176\",\"175\",\"174\",\"173\",\"172\",\"158\",\"163\",\"162\",\"161\",\"160\",\"159\",\"77\",\"47\",\"46\",\"48\",\"51\",\"50\",\"49\",\"52\",\"54\",\"53\",\"55\",\"56\",\"60\",\"59\",\"58\",\"57\",\"61\",\"65\",\"64\",\"63\",\"62\",\"66\",\"70\",\"69\",\"68\",\"67\",\"71\",\"75\",\"74\",\"73\",\"72\",\"2\",\"3\",\"8\",\"44\",\"45\"],\"status\":\"1\",\"update_time\":\"1770530411\",\"create_time\":\"1770530411\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771750027),
(89, 2, 'one', '/house-admin-v2/public/admin/Index/login', '登录', '{\"username\":\"one\",\"password\":\"***\",\"keep\":\"1\",\"captchaId\":\"96532722-2a0f-4fe0-8d38-0d74dfead1b8\",\"captchaInfo\":\"\"}', '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 1771750046);

-- --------------------------------------------------------

--
-- 表的结构 `admin_rule`
--

CREATE TABLE `admin_rule` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `type` enum('menu_dir','menu','button') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:menu_dir=菜单目录,menu=菜单项,button=页面按钮',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `keepalive` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '缓存:0=关闭,1=开启',
  `extend` enum('none','add_rules_only','add_menu_only') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单和权限规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `admin_rule`
--

INSERT INTO `admin_rule` (`id`, `pid`, `type`, `title`, `name`, `path`, `icon`, `menu_type`, `url`, `component`, `keepalive`, `extend`, `remark`, `weigh`, `status`, `update_time`, `create_time`) VALUES
(1, 0, 'menu', '控制台', 'dashboard', 'dashboard', 'fa fa-dashboard', 'tab', '', '/src/views/backend/dashboard.vue', 1, 'none', 'Remark lang', 1130, 1, 1770530411, 1770530411),
(2, 0, 'menu_dir', '权限管理', 'auth', 'auth', 'fa fa-group', NULL, '', '', 0, 'none', '', 231, 1, 1770530411, 1770530411),
(3, 2, 'menu', '角色组管理', 'auth/group', 'auth/group', 'fa fa-group', 'tab', '', '/src/views/backend/auth/group/index.vue', 1, 'none', 'Remark lang', 230, 1, 1770530411, 1770530411),
(4, 3, 'button', '查看', 'auth/group/index', '', '', NULL, '', '', 0, 'none', '', -8, 1, 1770530411, 1770530411),
(5, 3, 'button', '添加', 'auth/group/add', '', '', NULL, '', '', 0, 'none', '', -7, 1, 1770535425, 1770530411),
(6, 3, 'button', '编辑', 'auth/group/edit', '', '', NULL, '', '', 0, 'none', '', -6, 1, 1770535425, 1770530411),
(7, 3, 'button', '删除', 'auth/group/del', '', '', NULL, '', '', 0, 'none', '', -5, 1, 1770535425, 1770530411),
(8, 2, 'menu', '管理员管理', 'auth/admin', 'auth/admin', 'el-icon-UserFilled', 'tab', '', '/src/views/backend/auth/admin/index.vue', 1, 'none', '', 229, 1, 1770530411, 1770530411),
(9, 8, 'button', '查看', 'auth/admin/index', '', '', NULL, '', '', 0, 'none', '', -4, 1, 1770535425, 1770530411),
(10, 8, 'button', '添加', 'auth/admin/add', '', '', NULL, '', '', 0, 'none', '', -3, 1, 1770535425, 1770530411),
(11, 8, 'button', '编辑', 'auth/admin/edit', '', '', NULL, '', '', 0, 'none', '', -2, 1, 1770535425, 1770530411),
(12, 8, 'button', '删除', 'auth/admin/del', '', '', NULL, '', '', 0, 'none', '', -1, 1, 1770535425, 1770530411),
(13, 2, 'menu', '菜单规则管理', 'auth/rule', 'auth/rule', 'el-icon-Grid', 'tab', '', '/src/views/backend/auth/rule/index.vue', 1, 'none', '', 228, 1, 1770530411, 1770530411),
(14, 13, 'button', '查看', 'auth/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770535425, 1770530411),
(15, 13, 'button', '添加', 'auth/rule/add', '', '', NULL, '', '', 0, 'none', '', 1, 1, 1770535425, 1770530411),
(16, 13, 'button', '编辑', 'auth/rule/edit', '', '', NULL, '', '', 0, 'none', '', 2, 1, 1770535425, 1770530411),
(17, 13, 'button', '删除', 'auth/rule/del', '', '', NULL, '', '', 0, 'none', '', 3, 1, 1770535425, 1770530411),
(18, 13, 'button', '快速排序', 'auth/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 4, 1, 1770535425, 1770530411),
(19, 2, 'menu', '管理员日志管理', 'auth/adminLog', 'auth/adminLog', 'el-icon-List', 'tab', '', '/src/views/backend/auth/adminLog/index.vue', 1, 'none', '', 227, 1, 1770530411, 1770530411),
(20, 19, 'button', '查看', 'auth/adminLog/index', '', '', NULL, '', '', 0, 'none', '', 5, 1, 1770535425, 1770530411),
(21, 0, 'menu_dir', '会员管理', 'user', 'user', 'fa fa-drivers-license', NULL, '', '', 0, 'none', '', 223, 1, 1770535364, 1770530411),
(22, 21, 'menu', '会员管理', 'user/user', 'user/user', 'fa fa-user', 'tab', '', '/src/views/backend/user/user/index.vue', 1, 'none', '', 222, 1, 1770530411, 1770530411),
(23, 22, 'button', '查看', 'user/user/index', '', '', NULL, '', '', 0, 'none', '', 6, 1, 1770535425, 1770530411),
(24, 22, 'button', '添加', 'user/user/add', '', '', NULL, '', '', 0, 'none', '', 7, 1, 1770535425, 1770530411),
(25, 22, 'button', '编辑', 'user/user/edit', '', '', NULL, '', '', 0, 'none', '', 8, 1, 1770535425, 1770530411),
(26, 22, 'button', '删除', 'user/user/del', '', '', NULL, '', '', 0, 'none', '', 9, 1, 1770535425, 1770530411),
(27, 21, 'menu', '会员分组管理', 'user/group', 'user/group', 'fa fa-group', 'tab', '', '/src/views/backend/user/group/index.vue', 1, 'none', '', 221, 1, 1770530411, 1770530411),
(28, 27, 'button', '查看', 'user/group/index', '', '', NULL, '', '', 0, 'none', '', 10, 1, 1770535425, 1770530411),
(29, 27, 'button', '添加', 'user/group/add', '', '', NULL, '', '', 0, 'none', '', 11, 1, 1770535425, 1770530411),
(30, 27, 'button', '编辑', 'user/group/edit', '', '', NULL, '', '', 0, 'none', '', 12, 1, 1770535425, 1770530411),
(31, 27, 'button', '删除', 'user/group/del', '', '', NULL, '', '', 0, 'none', '', 13, 1, 1770535425, 1770530411),
(32, 21, 'menu', '会员规则管理', 'user/rule', 'user/rule', 'fa fa-th-list', 'tab', '', '/src/views/backend/user/rule/index.vue', 1, 'none', '', 220, 1, 1770530411, 1770530411),
(33, 32, 'button', '查看', 'user/rule/index', '', '', NULL, '', '', 0, 'none', '', 14, 1, 1770535425, 1770530411),
(34, 32, 'button', '添加', 'user/rule/add', '', '', NULL, '', '', 0, 'none', '', 15, 1, 1770535425, 1770530411),
(35, 32, 'button', '编辑', 'user/rule/edit', '', '', NULL, '', '', 0, 'none', '', 16, 1, 1770535425, 1770530411),
(36, 32, 'button', '删除', 'user/rule/del', '', '', NULL, '', '', 0, 'none', '', 17, 1, 1770535425, 1770530411),
(37, 32, 'button', '快速排序', 'user/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 18, 1, 1770535425, 1770530411),
(38, 21, 'menu', '会员余额管理', 'user/moneyLog', 'user/moneyLog', 'el-icon-Money', 'tab', '', '/src/views/backend/user/moneyLog/index.vue', 1, 'none', '', 219, 1, 1770530411, 1770530411),
(39, 38, 'button', '查看', 'user/moneyLog/index', '', '', NULL, '', '', 0, 'none', '', 19, 1, 1770535425, 1770530411),
(40, 38, 'button', '添加', 'user/moneyLog/add', '', '', NULL, '', '', 0, 'none', '', 20, 1, 1770535425, 1770530411),
(41, 21, 'menu', '会员积分管理', 'user/scoreLog', 'user/scoreLog', 'el-icon-Discount', 'tab', '', '/src/views/backend/user/scoreLog/index.vue', 1, 'none', '', 218, 1, 1770530411, 1770530411),
(42, 41, 'button', '查看', 'user/scoreLog/index', '', '', NULL, '', '', 0, 'none', '', 21, 1, 1770535425, 1770530411),
(43, 41, 'button', '添加', 'user/scoreLog/add', '', '', NULL, '', '', 0, 'none', '', 22, 1, 1770535425, 1770530411),
(44, 0, 'menu_dir', '常规管理', 'routine', 'routine', 'fa fa-cogs', NULL, '', '', 0, 'none', '', 217, 1, 1770530411, 1770530411),
(45, 44, 'menu', '系统配置', 'routine/config', 'routine/config', 'el-icon-Tools', 'tab', '', '/src/views/backend/routine/config/index.vue', 1, 'none', '', 216, 1, 1770530411, 1770530411),
(46, 45, 'button', '查看', 'routine/config/index', '', '', NULL, '', '', 0, 'none', '', 23, 1, 1770535425, 1770530411),
(47, 45, 'button', '编辑', 'routine/config/edit', '', '', NULL, '', '', 0, 'none', '', 24, 1, 1770535425, 1770530411),
(48, 44, 'menu', '附件管理', 'routine/attachment', 'routine/attachment', 'fa fa-folder', 'tab', '', '/src/views/backend/routine/attachment/index.vue', 1, 'none', 'Remark lang', 215, 1, 1770530411, 1770530411),
(49, 48, 'button', '查看', 'routine/attachment/index', '', '', NULL, '', '', 0, 'none', '', 25, 1, 1770535425, 1770530411),
(50, 48, 'button', '编辑', 'routine/attachment/edit', '', '', NULL, '', '', 0, 'none', '', 26, 1, 1770535425, 1770530411),
(51, 48, 'button', '删除', 'routine/attachment/del', '', '', NULL, '', '', 0, 'none', '', 27, 1, 1770535425, 1770530411),
(52, 44, 'menu', '个人资料', 'routine/adminInfo', 'routine/adminInfo', 'fa fa-user', 'tab', '', '/src/views/backend/routine/adminInfo.vue', 1, 'none', '', 214, 1, 1770530411, 1770530411),
(53, 52, 'button', '查看', 'routine/adminInfo/index', '', '', NULL, '', '', 0, 'none', '', 28, 1, 1770535425, 1770530411),
(54, 52, 'button', '编辑', 'routine/adminInfo/edit', '', '', NULL, '', '', 0, 'none', '', 29, 1, 1770535425, 1770530411),
(55, 0, 'menu_dir', '数据安全管理', 'security', 'security', 'fa fa-shield', NULL, '', '', 0, 'none', '', 212, 1, 1770535353, 1770530411),
(56, 55, 'menu', '数据回收站', 'security/dataRecycleLog', 'security/dataRecycleLog', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycleLog/index.vue', 1, 'none', '', 211, 1, 1770530411, 1770530411),
(57, 56, 'button', '查看', 'security/dataRecycleLog/index', '', '', NULL, '', '', 0, 'none', '', 30, 1, 1770535425, 1770530411),
(58, 56, 'button', '删除', 'security/dataRecycleLog/del', '', '', NULL, '', '', 0, 'none', '', 31, 1, 1770535425, 1770530411),
(59, 56, 'button', '还原', 'security/dataRecycleLog/restore', '', '', NULL, '', '', 0, 'none', '', 32, 1, 1770535425, 1770530411),
(60, 56, 'button', '查看详情', 'security/dataRecycleLog/info', '', '', NULL, '', '', 0, 'none', '', 33, 1, 1770535425, 1770530411),
(61, 55, 'menu', '敏感数据修改记录', 'security/sensitiveDataLog', 'security/sensitiveDataLog', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveDataLog/index.vue', 1, 'none', '', 210, 1, 1770530411, 1770530411),
(62, 61, 'button', '查看', 'security/sensitiveDataLog/index', '', '', NULL, '', '', 0, 'none', '', 34, 1, 1770535425, 1770530411),
(63, 61, 'button', '删除', 'security/sensitiveDataLog/del', '', '', NULL, '', '', 0, 'none', '', 35, 1, 1770535425, 1770530411),
(64, 61, 'button', '回滚', 'security/sensitiveDataLog/rollback', '', '', NULL, '', '', 0, 'none', '', 36, 1, 1770535425, 1770530411),
(65, 61, 'button', '查看详情', 'security/sensitiveDataLog/info', '', '', NULL, '', '', 0, 'none', '', 37, 1, 1770535425, 1770530411),
(66, 55, 'menu', '数据回收规则管理', 'security/dataRecycle', 'security/dataRecycle', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycle/index.vue', 1, 'none', 'Remark lang', 209, 1, 1770530411, 1770530411),
(67, 66, 'button', '查看', 'security/dataRecycle/index', '', '', NULL, '', '', 0, 'none', '', 38, 1, 1770535425, 1770530411),
(68, 66, 'button', '添加', 'security/dataRecycle/add', '', '', NULL, '', '', 0, 'none', '', 39, 1, 1770535425, 1770530411),
(69, 66, 'button', '编辑', 'security/dataRecycle/edit', '', '', NULL, '', '', 0, 'none', '', 40, 1, 1770535425, 1770530411),
(70, 66, 'button', '删除', 'security/dataRecycle/del', '', '', NULL, '', '', 0, 'none', '', 41, 1, 1770535425, 1770530411),
(71, 55, 'menu', '敏感字段规则管理', 'security/sensitiveData', 'security/sensitiveData', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveData/index.vue', 1, 'none', 'Remark lang', 208, 1, 1770530411, 1770530411),
(72, 71, 'button', '查看', 'security/sensitiveData/index', '', '', NULL, '', '', 0, 'none', '', 42, 1, 1770535425, 1770530411),
(73, 71, 'button', '添加', 'security/sensitiveData/add', '', '', NULL, '', '', 0, 'none', '', 43, 1, 1770535425, 1770530411),
(74, 71, 'button', '编辑', 'security/sensitiveData/edit', '', '', NULL, '', '', 0, 'none', '', 44, 1, 1770535425, 1770530411),
(75, 71, 'button', '删除', 'security/sensitiveData/del', '', '', NULL, '', '', 0, 'none', '', 45, 1, 1770535425, 1770530411),
(77, 45, 'button', '添加', 'routine/config/add', '', '', NULL, '', '', 0, 'none', '', 46, 1, 1770535425, 1770530411),
(78, 0, 'menu', '模块市场', 'moduleStore/moduleStore', 'moduleStore', 'el-icon-GoodsFilled', 'tab', '', '/src/views/backend/module/index.vue', 1, 'none', '', 214, 1, 1770530411, 1770530411),
(79, 78, 'button', '查看', 'moduleStore/moduleStore/index', '', '', NULL, '', '', 0, 'none', '', 47, 1, 1770535425, 1770530411),
(80, 78, 'button', '安装', 'moduleStore/moduleStore/install', '', '', NULL, '', '', 0, 'none', '', 48, 1, 1770535425, 1770530411),
(81, 78, 'button', '调整状态', 'moduleStore/moduleStore/changeState', '', '', NULL, '', '', 0, 'none', '', 49, 1, 1770535425, 1770530411),
(82, 78, 'button', '卸载', 'moduleStore/moduleStore/uninstall', '', '', NULL, '', '', 0, 'none', '', 50, 1, 1770535425, 1770530411),
(83, 78, 'button', '更新', 'moduleStore/moduleStore/update', '', '', NULL, '', '', 0, 'none', '', 51, 1, 1770535425, 1770530411),
(84, 0, 'menu', 'CRUD代码生成', 'crud/crud', 'crud/crud', 'fa fa-code', 'tab', '', '/src/views/backend/crud/index.vue', 1, 'none', '', 207, 1, 1770530411, 1770530411),
(85, 84, 'button', '查看', 'crud/crud/index', '', '', NULL, '', '', 0, 'none', '', 52, 1, 1770535425, 1770530411),
(86, 84, 'button', '生成', 'crud/crud/generate', '', '', NULL, '', '', 0, 'none', '', 53, 1, 1770535425, 1770530411),
(87, 84, 'button', '删除', 'crud/crud/delete', '', '', NULL, '', '', 0, 'none', '', 54, 1, 1770535425, 1770530411),
(88, 45, 'button', '删除', 'routine/config/del', '', '', NULL, '', '', 0, 'none', '', 55, 1, 1770535425, 1770530411),
(89, 1, 'button', '查看', 'dashboard/index', '', '', NULL, '', '', 0, 'none', '', 56, 1, 1770535425, 1770530411),
(90, 44, 'menu', '数据导出管理', 'routine/dataexport', 'routine/dataexport', 'fa fa-cloud-download', 'tab', '', '/src/views/backend/routine/dataexport/index.vue', 1, 'none', '', 57, 1, 1770535425, 1770531936),
(91, 90, 'button', '查看', 'routine/dataexport/index', '', '', NULL, '', '', 0, 'none', '', 58, 1, 1770535425, 1770531936),
(92, 90, 'button', '添加', 'routine/dataexport/add', '', '', NULL, '', '', 0, 'none', '', 59, 1, 1770535425, 1770531936),
(93, 90, 'button', '编辑', 'routine/dataexport/edit', '', '', NULL, '', '', 0, 'none', '', 60, 1, 1770535425, 1770531936),
(94, 90, 'button', '删除', 'routine/dataexport/del', '', '', NULL, '', '', 0, 'none', '', 61, 1, 1770535425, 1770531936),
(95, 90, 'button', '执行任务', 'routine/dataexport/start', '', '', NULL, '', '', 0, 'none', '', 62, 1, 1770535425, 1770531936),
(96, 44, 'menu', '导出任务控制', 'routine/dataexport/taskControl', 'routine/dataexport/taskControl/:id', 'fa fa-cloud-download', 'tab', '', '/src/views/backend/routine/dataexport/taskControl.vue', 1, 'add_rules_only', '', 63, 1, 1770535425, 1770531936),
(97, 0, 'menu_dir', '账号管理', 'account', 'account', 'el-icon-UserFilled', 'tab', '', '/src/views/backend/account/index.vue', 1, 'none', '', 226, 1, 1770535482, 1770532089),
(98, 97, 'button', '查看', 'account/index', '', '', NULL, '', '', 0, 'none', '', 64, 1, 1770535425, 1770532089),
(99, 97, 'button', '添加', 'account/add', '', '', NULL, '', '', 0, 'none', '', 65, 1, 1770535425, 1770532089),
(100, 97, 'button', '编辑', 'account/edit', '', '', NULL, '', '', 0, 'none', '', 66, 1, 1770535425, 1770532089),
(101, 97, 'button', '删除', 'account/del', '', '', NULL, '', '', 0, 'none', '', 67, 1, 1770535425, 1770532089),
(102, 97, 'button', '快速排序', 'account/sortable', '', '', NULL, '', '', 0, 'none', '', 68, 1, 1770535425, 1770532089),
(103, 0, 'menu_dir', '动态管理', 'dynamic', 'dynamic', 'el-icon-Comment', 'tab', '', '/src/views/backend/dynamic/index.vue', 1, 'none', '', 225, 1, 1770535504, 1770532182),
(104, 103, 'button', '查看', 'dynamic/index', '', '', NULL, '', '', 0, 'none', '', 69, 1, 1770535425, 1770532182),
(105, 103, 'button', '添加', 'dynamic/add', '', '', NULL, '', '', 0, 'none', '', 70, 1, 1770535425, 1770532182),
(106, 103, 'button', '编辑', 'dynamic/edit', '', '', NULL, '', '', 0, 'none', '', 71, 1, 1770535425, 1770532182),
(107, 103, 'button', '删除', 'dynamic/del', '', '', NULL, '', '', 0, 'none', '', 72, 1, 1770535425, 1770532182),
(108, 103, 'button', '快速排序', 'dynamic/sortable', '', '', NULL, '', '', 0, 'none', '', 73, 1, 1770535425, 1770532182),
(109, 103, 'menu', '动态图片管理', 'dynamic/image', 'dynamic/image', '', 'tab', '', '/src/views/backend/dynamic/image/index.vue', 1, 'none', '', 82, 1, 1770535441, 1770532240),
(110, 109, 'button', '查看', 'dynamic/image/index', '', '', NULL, '', '', 0, 'none', '', 76, 1, 1770535425, 1770532240),
(111, 109, 'button', '添加', 'dynamic/image/add', '', '', NULL, '', '', 0, 'none', '', 77, 1, 1770535425, 1770532240),
(112, 109, 'button', '编辑', 'dynamic/image/edit', '', '', NULL, '', '', 0, 'none', '', 78, 1, 1770535425, 1770532240),
(113, 109, 'button', '删除', 'dynamic/image/del', '', '', NULL, '', '', 0, 'none', '', 79, 1, 1770535425, 1770532240),
(114, 109, 'button', '快速排序', 'dynamic/image/sortable', '', '', NULL, '', '', 0, 'none', '', 80, 1, 1770535425, 1770532240),
(115, 103, 'menu', '动态视频管理', 'dynamic/video', 'dynamic/video', '', 'tab', '', '/src/views/backend/dynamic/video/index.vue', 1, 'none', '', 81, 1, 1770535441, 1770532468),
(116, 115, 'button', '查看', 'dynamic/video/index', '', '', NULL, '', '', 0, 'none', '', 84, 1, 1770535425, 1770532468),
(117, 115, 'button', '添加', 'dynamic/video/add', '', '', NULL, '', '', 0, 'none', '', 85, 1, 1770535425, 1770532468),
(118, 115, 'button', '编辑', 'dynamic/video/edit', '', '', NULL, '', '', 0, 'none', '', 86, 1, 1770535425, 1770532468),
(119, 115, 'button', '删除', 'dynamic/video/del', '', '', NULL, '', '', 0, 'none', '', 87, 1, 1770535425, 1770532468),
(120, 115, 'button', '快速排序', 'dynamic/video/sortable', '', '', NULL, '', '', 0, 'none', '', 88, 1, 1770535425, 1770532468),
(121, 103, 'menu', '动态管理', 'dynamic/dynamic', 'dynamic/dynamic', '', 'tab', '', '/src/views/backend/dynamic/dynamic/index.vue', 1, 'none', '', 83, 1, 1770535436, 1770534501),
(122, 121, 'button', '查看', 'dynamic/dynamic/index', '', '', NULL, '', '', 0, 'none', '', 90, 1, 1770535425, 1770534501),
(123, 121, 'button', '添加', 'dynamic/dynamic/add', '', '', NULL, '', '', 0, 'none', '', 91, 1, 1770535425, 1770534501),
(124, 121, 'button', '编辑', 'dynamic/dynamic/edit', '', '', NULL, '', '', 0, 'none', '', 92, 1, 1770535425, 1770534501),
(125, 121, 'button', '删除', 'dynamic/dynamic/del', '', '', NULL, '', '', 0, 'none', '', 93, 1, 1770535425, 1770534501),
(126, 121, 'button', '快速排序', 'dynamic/dynamic/sortable', '', '', NULL, '', '', 0, 'none', '', 94, 1, 1770535425, 1770534501),
(127, 97, 'menu', '账号管理', 'account/account', 'account/account', '', 'tab', '', '/src/views/backend/account/account/index.vue', 1, 'none', '', 95, 1, 1770535425, 1770534529),
(128, 127, 'button', '查看', 'account/account/index', '', '', NULL, '', '', 0, 'none', '', 96, 1, 1770535425, 1770534529),
(129, 127, 'button', '添加', 'account/account/add', '', '', NULL, '', '', 0, 'none', '', 97, 1, 1770535425, 1770534529),
(130, 127, 'button', '编辑', 'account/account/edit', '', '', NULL, '', '', 0, 'none', '', 98, 1, 1770535425, 1770534529),
(131, 127, 'button', '删除', 'account/account/del', '', '', NULL, '', '', 0, 'none', '', 99, 1, 1770535425, 1770534529),
(132, 127, 'button', '快速排序', 'account/account/sortable', '', '', NULL, '', '', 0, 'none', '', 100, 1, 1770535425, 1770534529),
(133, 0, 'menu_dir', '房源管理', 'propertylisting', 'propertylisting', 'el-icon-HomeFilled', NULL, '', '', 0, 'none', '', 224, 1, 1770535514, 1770534601),
(134, 133, 'menu', '房源管理', 'propertylisting/listing', 'propertylisting/listing', 'el-icon-HomeFilled', 'tab', '', '/src/views/backend/propertylisting/listing/index.vue', 1, 'none', '', 122, 1, 1771749832, 1770534601),
(135, 134, 'button', '查看', 'propertylisting/listing/index', '', '', NULL, '', '', 0, 'none', '', 102, 1, 1770535425, 1770534601),
(136, 134, 'button', '添加', 'propertylisting/listing/add', '', '', NULL, '', '', 0, 'none', '', 103, 1, 1770535425, 1770534601),
(137, 134, 'button', '编辑', 'propertylisting/listing/edit', '', '', NULL, '', '', 0, 'none', '', 104, 1, 1770535425, 1770534601),
(138, 134, 'button', '删除', 'propertylisting/listing/del', '', '', NULL, '', '', 0, 'none', '', 105, 1, 1770535425, 1770534601),
(139, 134, 'button', '快速排序', 'propertylisting/listing/sortable', '', '', NULL, '', '', 0, 'none', '', 106, 1, 1770535425, 1770534601),
(140, 133, 'menu', '房源图片管理', 'propertylisting/image', 'propertylisting/image', '', 'tab', '', '/src/views/backend/propertylisting/image/index.vue', 1, 'none', '', 115, 1, 1770535460, 1770534664),
(141, 140, 'button', '查看', 'propertylisting/image/index', '', '', NULL, '', '', 0, 'none', '', 109, 1, 1770535425, 1770534664),
(142, 140, 'button', '添加', 'propertylisting/image/add', '', '', NULL, '', '', 0, 'none', '', 110, 1, 1770535425, 1770534664),
(143, 140, 'button', '编辑', 'propertylisting/image/edit', '', '', NULL, '', '', 0, 'none', '', 111, 1, 1770535425, 1770534664),
(144, 140, 'button', '删除', 'propertylisting/image/del', '', '', NULL, '', '', 0, 'none', '', 112, 1, 1770535425, 1770534664),
(145, 140, 'button', '快速排序', 'propertylisting/image/sortable', '', '', NULL, '', '', 0, 'none', '', 113, 1, 1770535425, 1770534664),
(146, 133, 'menu', '房源视频管理', 'propertylisting/video', 'propertylisting/video', 'fa fa-circle-o', 'tab', '', '/src/views/backend/propertylisting/video/index.vue', 1, 'none', '', 114, 1, 1770535460, 1770534732),
(147, 146, 'button', '查看', 'propertylisting/video/index', '', '', NULL, '', '', 0, 'none', '', 116, 1, 1770535425, 1770534732),
(148, 146, 'button', '添加', 'propertylisting/video/add', '', '', NULL, '', '', 0, 'none', '', 117, 1, 1770535425, 1770534732),
(149, 146, 'button', '编辑', 'propertylisting/video/edit', '', '', NULL, '', '', 0, 'none', '', 118, 1, 1770535425, 1770534732),
(150, 146, 'button', '删除', 'propertylisting/video/del', '', '', NULL, '', '', 0, 'none', '', 119, 1, 1770535425, 1770534732),
(151, 146, 'button', '快速排序', 'propertylisting/video/sortable', '', '', NULL, '', '', 0, 'none', '', 120, 1, 1770535425, 1770534732),
(152, 133, 'menu', '房源账单管理', 'propertylisting/order', 'propertylisting/order', '', 'tab', '', '/src/views/backend/propertylisting/order/index.vue', 1, 'none', '', 107, 1, 1770535457, 1770535094),
(153, 152, 'button', '查看', 'propertylisting/order/index', '', '', NULL, '', '', 0, 'none', '', 123, 1, 1770535425, 1770535094),
(154, 152, 'button', '添加', 'propertylisting/order/add', '', '', NULL, '', '', 0, 'none', '', 124, 1, 1770535425, 1770535094),
(155, 152, 'button', '编辑', 'propertylisting/order/edit', '', '', NULL, '', '', 0, 'none', '', 125, 1, 1770535425, 1770535094),
(156, 152, 'button', '删除', 'propertylisting/order/del', '', '', NULL, '', '', 0, 'none', '', 126, 1, 1770535425, 1770535094),
(157, 152, 'button', '快速排序', 'propertylisting/order/sortable', '', '', NULL, '', '', 0, 'none', '', 127, 1, 1770535425, 1770535094),
(158, 133, 'menu', '房源访客管理', 'propertylisting/visitor', 'propertylisting/visitor', '', 'tab', '', '/src/views/backend/propertylisting/visitor/index.vue', 1, 'none', '', 0, 1, 1770709851, 1770709851),
(159, 158, 'button', '查看', 'propertylisting/visitor/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709851, 1770709851),
(160, 158, 'button', '添加', 'propertylisting/visitor/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709851, 1770709851),
(161, 158, 'button', '编辑', 'propertylisting/visitor/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709851, 1770709851),
(162, 158, 'button', '删除', 'propertylisting/visitor/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709851, 1770709851),
(163, 158, 'button', '快速排序', 'propertylisting/visitor/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709851, 1770709851),
(171, 133, 'menu', '房源收藏管理', 'propertylisting/favorites', 'propertylisting/favorites', '', 'tab', '', '/src/views/backend/propertylisting/favorites/index.vue', 1, 'none', '', 0, 1, 1770709989, 1770709989),
(172, 171, 'button', '查看', 'propertylisting/favorites/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709989, 1770709989),
(173, 171, 'button', '添加', 'propertylisting/favorites/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709989, 1770709989),
(174, 171, 'button', '编辑', 'propertylisting/favorites/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709989, 1770709989),
(175, 171, 'button', '删除', 'propertylisting/favorites/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709989, 1770709989),
(176, 171, 'button', '快速排序', 'propertylisting/favorites/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1770709989, 1770709989);

-- --------------------------------------------------------

--
-- 表的结构 `area`
--

CREATE TABLE `area` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int(11) UNSIGNED DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简称',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) UNSIGNED DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首字母',
  `lng` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='省份地区表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `attachment`
--

CREATE TABLE `attachment` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `topic` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '细目',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传管理员ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传用户ID',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '物理路径',
  `width` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '宽度',
  `height` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '高度',
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '原始名称',
  `size` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '大小',
  `mimetype` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'mime类型',
  `quote` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传(引用)次数',
  `storage` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储方式',
  `sha1` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sha1编码',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `last_upload_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '最后上传时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='附件表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `attachment`
--

INSERT INTO `attachment` (`id`, `topic`, `admin_id`, `user_id`, `url`, `width`, `height`, `name`, `size`, `mimetype`, `quote`, `storage`, `sha1`, `create_time`, `last_upload_time`) VALUES
(1, 'default', 1, 0, '/storage/default/20260210/房源809f0851b0216294e0898d9ce0a458f3396a907e.png', 1546, 1760, '房源.png', 156070, 'image/png', 1, 'local', '809f0851b0216294e0898d9ce0a458f3396a907e', 1770710271, 1770710271);

-- --------------------------------------------------------

--
-- 表的结构 `captcha`
--

CREATE TABLE `captcha` (
  `key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码Key',
  `code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码(加密后)',
  `captcha` text COLLATE utf8mb4_unicode_ci COMMENT '验证码数据',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '过期时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='验证码表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `config`
--

CREATE TABLE `config` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量输入组件类型',
  `value` longtext COLLATE utf8mb4_unicode_ci COMMENT '变量值',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '字典数据',
  `rule` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  `allow_del` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '允许删除:0=否,1=是',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `config`
--

INSERT INTO `config` (`id`, `name`, `group`, `title`, `tip`, `type`, `value`, `content`, `rule`, `extend`, `allow_del`, `weigh`) VALUES
(1, 'config_group', 'basics', 'Config group', '', 'array', '[{\"key\":\"basics\",\"value\":\"Basics\"},{\"key\":\"mail\",\"value\":\"Mail\"},{\"key\":\"config_quick_entrance\",\"value\":\"Config Quick entrance\"}]', NULL, 'required', '', 0, -1),
(2, 'site_name', 'basics', 'Site Name', '', 'string', 'house-admin', NULL, 'required', '', 0, 99),
(3, 'record_number', 'basics', 'Record number', '域名备案号', 'string', '渝ICP备8888888号-1', NULL, '', '', 0, 0),
(4, 'version', 'basics', 'Version number', '系统版本号', 'string', 'v1.0.0', NULL, 'required', '', 0, 0),
(5, 'time_zone', 'basics', 'time zone', '', 'string', 'Asia/Shanghai', NULL, 'required', '', 0, 0),
(6, 'no_access_ip', 'basics', 'No access ip', '禁止访问站点的ip列表,一行一个', 'textarea', NULL, NULL, '', '', 0, 0),
(7, 'smtp_server', 'mail', 'smtp server', '', 'string', 'smtp.qq.com', NULL, '', '', 0, 9),
(8, 'smtp_port', 'mail', 'smtp port', '', 'string', '465', NULL, '', '', 0, 8),
(9, 'smtp_user', 'mail', 'smtp user', '', 'string', NULL, NULL, '', '', 0, 7),
(10, 'smtp_pass', 'mail', 'smtp pass', '', 'string', NULL, NULL, '', '', 0, 6),
(11, 'smtp_verification', 'mail', 'smtp verification', '', 'select', 'SSL', '{\"SSL\":\"SSL\",\"TLS\":\"TLS\"}', '', '', 0, 5),
(12, 'smtp_sender_mail', 'mail', 'smtp sender mail', '', 'string', NULL, NULL, 'email', '', 0, 4),
(13, 'config_quick_entrance', 'config_quick_entrance', 'Config Quick entrance', '', 'array', '[{\"key\":\"\\u6570\\u636e\\u56de\\u6536\\u89c4\\u5219\\u914d\\u7f6e\",\"value\":\"security\\/dataRecycle\"},{\"key\":\"\\u654f\\u611f\\u6570\\u636e\\u89c4\\u5219\\u914d\\u7f6e\",\"value\":\"security\\/sensitiveData\"}]', NULL, '', '', 0, 0),
(14, 'backend_entrance', 'basics', 'Backend entrance', '', 'string', '/admin', NULL, 'required', '', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `crud_log`
--

CREATE TABLE `crud_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `table_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表名',
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '注释',
  `table` text COLLATE utf8mb4_unicode_ci COMMENT '数据表数据',
  `fields` text COLLATE utf8mb4_unicode_ci COMMENT '字段数据',
  `sync` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '同步记录',
  `status` enum('delete','success','error','start') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'start' COMMENT '状态:delete=已删除,success=成功,error=失败,start=生成中',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `create_time` bigint(20) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRUD记录表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `crud_log`
--

INSERT INTO `crud_log` (`id`, `table_name`, `comment`, `table`, `fields`, `sync`, `status`, `connection`, `create_time`) VALUES
(1, 'account', '账号管理', '{\"name\":\"account\",\"comment\":\"账号管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"nickname\",\"avatar\"],\"columnFields\":[\"id\",\"openid\",\"nickname\",\"avatar\",\"create_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"account\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Account.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Account.php\",\"validateFile\":\"app\\/admin\\/validate\\/Account.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/account\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"账号id\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"nickname\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"昵称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"头像\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"create_time\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"注册时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770532089),
(2, 'dynamic', '动态管理', '{\"name\":\"dynamic\",\"comment\":\"动态管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"text\",\"telephone\",\"area\",\"address\",\"lat\",\"lng\"],\"columnFields\":[\"id\",\"create_time\",\"openid\",\"telephone\",\"area\",\"address\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Dynamic.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Dynamic.php\",\"validateFile\":\"app\\/admin\\/validate\\/Dynamic.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布者\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"text\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"文本\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"联系方式\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"area\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"位置\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"address\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细位置\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"纬度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"经度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770532182),
(3, 'dynamic_image', '动态图片管理', '{\"name\":\"dynamic_image\",\"comment\":\"动态图片管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"dynamic_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"dynamic_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic_image\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/dynamic\\/Image.php\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Image.php\",\"validateFile\":\"app\\/admin\\/validate\\/dynamic\\/Image.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/image\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"dynamic_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"主表id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"dynamic\",\"remote-controller\":\"app\\/admin\\/controller\\/Dynamic.php\",\"remote-model\":\"app\\/admin\\/model\\/Dynamic.php\",\"relation-fields\":\"area,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"路径\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"次序\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]', 0, 'success', 'mysql', 1770532240),
(4, 'dynamic_video', '动态视频管理', '{\"name\":\"dynamic_video\",\"comment\":\"动态视频管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"dynamic_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"dynamic_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic_video\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/dynamic\\/Video.php\",\"controllerFile\":\"app\\/admin\\/controller\\/dynamic\\/Video.php\",\"validateFile\":\"app\\/admin\\/validate\\/dynamic\\/Video.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/video\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"dynamic_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"主表id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"dynamic\",\"remote-controller\":\"app\\/admin\\/controller\\/Dynamic.php\",\"remote-model\":\"app\\/admin\\/model\\/Dynamic.php\",\"relation-fields\":\"area,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"路径\",\"designType\":\"file\",\"table\":{\"render\":\"url\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"file-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"次序\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]', 0, 'success', 'mysql', 1770532467),
(5, 'dynamic', '动态管理', '{\"name\":\"dynamic\",\"comment\":\"动态管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"text\",\"telephone\",\"area\",\"address\",\"lat\",\"lng\"],\"columnFields\":[\"id\",\"create_time\",\"openid\",\"telephone\",\"area\",\"address\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"dynamic\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Dynamic.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Dynamic.php\",\"validateFile\":\"app\\/admin\\/validate\\/Dynamic.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/dynamic\\/dynamic\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布者\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"text\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"文本\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"联系方式\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"area\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"位置\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"address\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细位置\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"纬度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"经度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770534501),
(6, 'account', '账号管理', '{\"name\":\"account\",\"comment\":\"账号管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"nickname\",\"avatar\"],\"columnFields\":[\"id\",\"openid\",\"nickname\",\"avatar\",\"create_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"account\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/Account.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Account.php\",\"validateFile\":\"app\\/admin\\/validate\\/Account.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/account\\/account\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"账号id\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"nickname\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"昵称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"头像\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"create_time\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"注册时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770534529),
(7, 'property_listing', '房源管理', '{\"name\":\"property_listing\",\"comment\":\"房源管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"city\",\"address\",\"lat\",\"lng\",\"rentType\",\"house\",\"area\",\"money\",\"introduction\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"columnFields\":[\"id\",\"openid\",\"city\",\"address\",\"rentType\",\"house\",\"area\",\"money\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/Listing.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布人\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"city\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"城市\",\"designType\":\"city\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"address\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"纬度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"经度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"rentType\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"出租方式\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"house\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"户型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"area\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"面积\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"money\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"价格\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"introduction\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细介绍\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"联系方式\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"type\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"类型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"上架时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770534601),
(8, 'property_listing_image', '房源图片管理', '{\"name\":\"property_listing_image\",\"comment\":\"房源图片管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"property_listing_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_image\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Image.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Image.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Image.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/image\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"父表id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"文件\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"次序\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]', 0, 'success', 'mysql', 1770534664),
(9, 'property_listing', '房源管理', '{\"name\":\"property_listing\",\"comment\":\"房源管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"city\",\"address\",\"lat\",\"lng\",\"rentType\",\"house\",\"area\",\"money\",\"introduction\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"columnFields\":[\"id\",\"openid\",\"city\",\"address\",\"rentType\",\"house\",\"area\",\"money\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/Listing.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布人\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"city\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"城市\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"false\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"address\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"纬度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"经度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"rentType\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"出租方式\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"house\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"户型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"area\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"面积\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"money\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"价格\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"introduction\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细介绍\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"联系方式\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"type\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"类型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"上架时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770534689),
(10, 'property_listing_video', '', '{\"name\":\"property_listing_video\",\"comment\":\"\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"file\",\"sort\"],\"columnFields\":[\"id\",\"property_listing_id\",\"sort\",\"file\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_video\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Video.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Video.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Video.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/video\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"父表id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"file\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"文件\",\"designType\":\"file\",\"table\":{\"render\":\"url\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"file-multi\":\"\"}},{\"name\":\"sort\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"次序\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}}]', 0, 'success', 'mysql', 1770534732),
(11, 'property_listing_order', '房源账单管理', '{\"name\":\"property_listing_order\",\"comment\":\"房源账单管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"type\",\"trade_no\",\"openid\",\"status\"],\"columnFields\":[\"id\",\"property_listing_id\",\"trade_no\",\"openid\",\"status\",\"create_time\",\"type\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_order\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Order.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Order.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Order.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/order\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"主表id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"type\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商品名\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"账号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付状态\",\"designType\":\"switch\",\"table\":{\"render\":\"switch\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"下单时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770535094),
(12, 'property_listing', '房源管理', '{\"name\":\"property_listing\",\"comment\":\"房源管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"openid\",\"city\",\"address\",\"lat\",\"lng\",\"rentType\",\"house\",\"area\",\"money\",\"introduction\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"columnFields\":[\"id\",\"openid\",\"city\",\"address\",\"rentType\",\"house\",\"area\",\"money\",\"telephone\",\"type\",\"time\",\"trade_no\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/Listing.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/listing\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"id\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"openid\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"发布人\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"city\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"城市\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"false\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"address\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lat\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"纬度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"lng\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"经度\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"rentType\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"出租方式\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"house\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"户型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"area\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"面积\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"money\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"价格\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"introduction\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"详细介绍\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"telephone\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"联系方式\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"type\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"类型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"上架时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(225)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770535151);
INSERT INTO `crud_log` (`id`, `table_name`, `comment`, `table`, `fields`, `sync`, `status`, `connection`, `create_time`) VALUES
(13, 'property_listing_visitor', '房源访客管理', '{\"name\":\"property_listing_visitor\",\"comment\":\"房源访客管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"openid\"],\"columnFields\":[\"id\",\"property_listing_id\",\"create_time\",\"openid\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_visitor\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Visitor.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Visitor.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Visitor.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/visitor\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"房源id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"访客\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"浏览时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1770709851),
(14, 'property_listing_favorites', '房源收藏管理', '{\"name\":\"property_listing_favorites\",\"comment\":\"房源收藏管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"openid\"],\"columnFields\":[\"id\",\"property_listing_id\",\"openid\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_favorites\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Favorites.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Favorites.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Favorites.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/property\\/listingfavorites\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"房源id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"用户\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}}]', 0, 'success', 'mysql', 1770709948),
(15, 'property_listing_favorites', '房源收藏管理', '{\"name\":\"property_listing_favorites\",\"comment\":\"房源收藏管理\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"property_listing_id\",\"openid\"],\"columnFields\":[\"id\",\"property_listing_id\",\"openid\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"property_listing_favorites\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\/admin\\/model\\/property\\/listing\\/Favorites.php\",\"controllerFile\":\"app\\/admin\\/controller\\/property\\/listing\\/Favorites.php\",\"validateFile\":\"app\\/admin\\/validate\\/property\\/listing\\/Favorites.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/propertylisting\\/favorites\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"No\",\"empty\":\"\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"索引\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"property_listing_id\",\"type\":\"int\",\"dataType\":\"int(11)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"房源id\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"id\",\"remote-table\":\"property_listing\",\"remote-controller\":\"app\\/admin\\/controller\\/property\\/Listing.php\",\"remote-model\":\"app\\/admin\\/model\\/property\\/Listing.php\",\"relation-fields\":\"city,address\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"openid\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"用户\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"openid\",\"remote-field\":\"openid\",\"remote-table\":\"account\",\"remote-controller\":\"app\\/admin\\/controller\\/Account.php\",\"remote-model\":\"app\\/admin\\/model\\/Account.php\",\"relation-fields\":\"nickname\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}}]', 0, 'success', 'mysql', 1770709989);

-- --------------------------------------------------------

--
-- 表的结构 `dataexport`
--

CREATE TABLE `dataexport` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '导出人',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '任务名称',
  `main_table` varchar(100) NOT NULL DEFAULT '' COMMENT '数据源表',
  `field_config` text COMMENT '字段配置',
  `join_table` text COMMENT '关联表配置',
  `where_field` text COMMENT '筛选规则',
  `order_field` text COMMENT '排序规则',
  `xls_max_number` int(7) UNSIGNED NOT NULL DEFAULT '10000' COMMENT '单个xls最大记录数',
  `concurrent_create_xls` tinyint(3) UNSIGNED NOT NULL DEFAULT '3' COMMENT '并发创建xls',
  `memory_limit` smallint(5) UNSIGNED NOT NULL DEFAULT '128' COMMENT '脚本内存限制(MB)',
  `export_number` int(10) UNSIGNED DEFAULT NULL COMMENT '导出记录数',
  `subtask` text COMMENT '子任务资料',
  `lastprogress` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次导出进度',
  `lastfile` varchar(255) NOT NULL DEFAULT '' COMMENT '上次导出文件',
  `lastexporttime` int(10) UNSIGNED DEFAULT NULL COMMENT '上次导出时间',
  `createtime` int(10) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='导出任务表';

--
-- 转存表中的数据 `dataexport`
--

INSERT INTO `dataexport` (`id`, `admin_id`, `name`, `main_table`, `field_config`, `join_table`, `where_field`, `order_field`, `xls_max_number`, `concurrent_create_xls`, `memory_limit`, `export_number`, `subtask`, `lastprogress`, `lastfile`, `lastexporttime`, `createtime`) VALUES
(1, 1, '1', 'dynamic', '[{\"name\":\"id\",\"discern\":\"int\",\"title\":\"索引\",\"comment\":\"\"},{\"name\":\"openid\",\"discern\":\"text\",\"title\":\"发布者\",\"comment\":\"\"},{\"name\":\"text\",\"discern\":\"text\",\"title\":\"文本\",\"comment\":\"\"},{\"name\":\"telephone\",\"discern\":\"text\",\"title\":\"联系方式\",\"comment\":\"\"},{\"name\":\"area\",\"discern\":\"text\",\"title\":\"位置\",\"comment\":\"\"},{\"name\":\"address\",\"discern\":\"text\",\"title\":\"详细位置\",\"comment\":\"\"},{\"name\":\"lat\",\"discern\":\"text\",\"title\":\"纬度\",\"comment\":\"\"},{\"name\":\"lng\",\"discern\":\"text\",\"title\":\"经度\",\"comment\":\"\"},{\"name\":\"create_time\",\"discern\":\"time\",\"title\":\"发布时间\",\"comment\":\"\"}]', '[]', '[]', NULL, 10000, 3, 128, NULL, '[{\"id\":0,\"status\":0,\"min\":0,\"max\":4,\"sql\":\"SELECT dynamic.id as dynamic_id,dynamic.openid as dynamic_openid,dynamic.text as dynamic_text,dynamic.telephone as dynamic_telephone,dynamic.area as dynamic_area,dynamic.address as dynamic_address,dynamic.lat as dynamic_lat,dynamic.lng as dynamic_lng,dynamic.create_time as dynamic_create_time FROM `dynamic` `dynamic` LIMIT 0,4\"}]', 0, '', 1770534819, 1770534816);

-- --------------------------------------------------------

--
-- 表的结构 `dynamic`
--

CREATE TABLE `dynamic` (
  `id` int(11) NOT NULL COMMENT '索引',
  `openid` text NOT NULL COMMENT '发布者',
  `text` text NOT NULL COMMENT '文本',
  `telephone` text NOT NULL COMMENT '联系方式',
  `area` text NOT NULL COMMENT '位置',
  `address` text NOT NULL COMMENT '详细位置',
  `lat` varchar(225) NOT NULL COMMENT '纬度',
  `lng` varchar(225) NOT NULL COMMENT '经度',
  `create_time` int(11) NOT NULL COMMENT '发布时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `dynamic`
--

INSERT INTO `dynamic` (`id`, `openid`, `text`, `telephone`, `area`, `address`, `lat`, `lng`, `create_time`) VALUES
(2, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '欧冠联赛阶段最后一轮，被称为“最残酷的一夜”。16场比赛同时开球，36支球队命运在90分钟内被重新排序，而这一夜，英超成为最大的赢家！北京时间1月29日凌晨，英超6支球队同时出战，最终5支球队杀入前八，创造欧冠历史纪录。', '1101171', '深业城', '佛山市-顺德区-北滘镇105国道与林港路交汇处', '23.076542098873', '113.14394526381', 1769500348),
(3, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '6666', '120', '深业城-三期', '佛山市-顺德区-深业城三期', '', '', 1769500464),
(4, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '33333', '119', '梅县腌面', '佛山市-禅城区-普澜二路新荣大厦', '', '', 1769500617),
(5, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '66666', '119', '正宗梅县客家腌面(平远横街店)', '佛山市-禅城区-平远横街36号首层3号', '', '', 1769500649);

-- --------------------------------------------------------

--
-- 表的结构 `dynamic_image`
--

CREATE TABLE `dynamic_image` (
  `id` int(11) NOT NULL COMMENT '索引',
  `dynamic_id` int(11) NOT NULL COMMENT '主表id',
  `file` varchar(225) NOT NULL COMMENT '路径',
  `sort` int(11) NOT NULL COMMENT '次序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `dynamic_image`
--

INSERT INTO `dynamic_image` (`id`, `dynamic_id`, `file`, `sort`) VALUES
(11, 2, 'http://192.168.93.112/uploads/动态图片/20260127/4f8ff5e5bf9d7d4d9ecd774881772b33.png', 1),
(12, 2, 'http://192.168.93.112/uploads/动态图片/20260127/006b71a94b9bdc39a83c4accaecb56df.png', 2);

-- --------------------------------------------------------

--
-- 表的结构 `dynamic_video`
--

CREATE TABLE `dynamic_video` (
  `id` int(11) NOT NULL COMMENT '索引',
  `dynamic_id` int(11) NOT NULL COMMENT '主表id',
  `file` varchar(225) NOT NULL COMMENT '路径',
  `sort` int(11) NOT NULL COMMENT '次序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `migrations`
--

CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `migrations`
--

INSERT INTO `migrations` (`version`, `migration_name`, `start_time`, `end_time`, `breakpoint`) VALUES
(20230620180908, 'Install', '2026-02-08 04:00:11', '2026-02-08 04:00:11', 0),
(20230620180916, 'InstallData', '2026-02-08 04:00:11', '2026-02-08 04:00:11', 0),
(20230622221507, 'Version200', '2026-02-08 04:00:11', '2026-02-08 04:00:11', 0),
(20230719211338, 'Version201', '2026-02-08 04:00:11', '2026-02-08 04:00:11', 0),
(20230905060702, 'Version202', '2026-02-08 04:00:11', '2026-02-08 04:00:11', 0),
(20231112093414, 'Version205', '2026-02-08 04:00:11', '2026-02-08 04:00:11', 0),
(20231229043002, 'Version206', '2026-02-08 04:00:11', '2026-02-08 04:00:12', 0),
(20250412134127, 'Version222', '2026-02-08 04:00:12', '2026-02-08 04:00:12', 0);

-- --------------------------------------------------------

--
-- 表的结构 `property_listing`
--

CREATE TABLE `property_listing` (
  `id` int(11) NOT NULL COMMENT 'id',
  `openid` varchar(225) NOT NULL COMMENT '发布人',
  `city` varchar(64) NOT NULL COMMENT '城市',
  `address` varchar(64) NOT NULL COMMENT '详细地址',
  `lat` varchar(225) NOT NULL COMMENT '纬度',
  `lng` varchar(225) NOT NULL COMMENT '经度',
  `rentType` varchar(64) DEFAULT NULL COMMENT '出租方式',
  `house` varchar(64) NOT NULL COMMENT '户型',
  `area` varchar(64) NOT NULL COMMENT '面积',
  `money` varchar(64) NOT NULL COMMENT '价格',
  `introduction` text NOT NULL COMMENT '详细介绍',
  `telephone` varchar(64) NOT NULL COMMENT '联系方式',
  `type` varchar(64) NOT NULL COMMENT '类型',
  `time` int(11) NOT NULL COMMENT '上架时间',
  `trade_no` varchar(225) NOT NULL COMMENT '订单号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `property_listing`
--

INSERT INTO `property_listing` (`id`, `openid`, `city`, `address`, `lat`, `lng`, `rentType`, `house`, `area`, `money`, `introduction`, `telephone`, `type`, `time`, `trade_no`) VALUES
(20, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '云路居民委员会', '', '', '合租', '2型', '50', '1000', '66', '110', '租赁', 1767604289, '20251206171128929802'),
(21, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '东二社区居民委员会', '', '', '整租', '1型', '50', '1000', '66666', '110', '租赁', 1767604362, '20251206171242606488'),
(22, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '北滘社区居民委员会', '', '', '整租', '2型', '50', '1500', '6666', '110', '租赁', 1770621686, '20260110152124336793'),
(23, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '北滘社区居民委员会', '', '', '整租', '2型', '50', '1500', '666', '110', '租赁', 1770622030, '20260110152709218731'),
(24, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '德', '', '', '整租', '2型', '50', '1500', '666', '119', '租赁', 1770622222, '20260110153021216223'),
(25, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区容桂街南区社区居民委员会', '', '', '整租', '2型', '50', '666', '666', '666', '租赁', 1770622763, '20260110153922361466'),
(26, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '云路居民委员会', '', '', '整租', '2型', '60', '5555', '666', '110', '租赁', 1771566944, '20260121135543626752'),
(27, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '云路居民委员会', '', '', '整租', '2型', '50', '1000', '666', '110', '租赁', 1771567092, '20260121135812468837'),
(28, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街北区社区居民委员会', '', '', '整租', '2型', '100', '2000', '666', '110', '租赁', 1771567352, '20260121140232498548'),
(29, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街北区社区居民委员会', '', '', '整租', '2型', '100', '2000', '666', '110', '租赁', 1771567440, '20260121140400154813'),
(30, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区容桂街南区社区居民委员会', '', '', '整租', '2型', '20', '500', '555', '120', '租赁', 1771570077, '20260121144757178950'),
(31, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街北区社区居民委员会', '', '', '整租', '2型', '20', '1000', '555', '110', '租赁', 1771571606, '20260121151326247599'),
(32, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区容桂街南区社区居民委员会', '', '', '整租', '2型', '500', '200', '555', '110', '租赁', 1771571803, '20260121151643227527'),
(33, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街北区社区居民委员会', '', '', '整租', '2型', '10', '1000', '666', '110', '租赁', 1771572595, '20260121152954719909'),
(34, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街府又社区居民委员会', '', '', '整租', '2型', '5400', '101', '02', '101', '租赁', 1771572968, '20260121153608268082'),
(35, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街府又社区居民委员会', '', '', '整租', '2型', '500', '1100', '55', '110', '租赁', 1771573509, '20260121154509432464'),
(36, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街府又社区居民委员会', '', '', '整租', '2型', '100', '00', '00', '00', '租赁', 1771574198, '20260121155638589138'),
(37, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区容桂街南区社区居民委员会', '', '', '整租', '2型', '500', '200', '121', '21', '租赁', 1771574722, '20260121160521727974'),
(38, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街北区社区居民委员会', '', '', '整租', '2型', '200', '1000', '12', '120', '租赁', 1771575202, '20260121161322142404'),
(39, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区大良街北区社区居民委员会', '', '', '整租', '2型', '200', '1000', '12', '120', '租赁', 1771575231, '20260121161351261573'),
(40, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '佛山市顺德区容桂街南区社区居民委员会', '', '', '整租', '2型', '100', '1010', '101', '1010', '租赁', 1771575994, '20260121162634431451'),
(41, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '深业城-一期', '', '', '整租', '3型', '100', '2520000', '666', '13455786521', '买卖', 1772004333, '20260126152532433761'),
(42, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', '佛山市', '深业城', '22.925342468556', '113.22338760359', '整租', '2型', '50', '6000', '5555', '119', '租赁', 1772350630, '20260130153708590115');

-- --------------------------------------------------------

--
-- 表的结构 `property_listing_favorites`
--

CREATE TABLE `property_listing_favorites` (
  `id` int(11) NOT NULL COMMENT '索引',
  `property_listing_id` int(11) NOT NULL COMMENT '房源id',
  `openid` text NOT NULL COMMENT '用户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `property_listing_favorites`
--

INSERT INTO `property_listing_favorites` (`id`, `property_listing_id`, `openid`) VALUES
(11, 24, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w'),
(12, 42, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w');

-- --------------------------------------------------------

--
-- 表的结构 `property_listing_image`
--

CREATE TABLE `property_listing_image` (
  `id` int(11) NOT NULL COMMENT 'id',
  `property_listing_id` int(11) NOT NULL COMMENT '父表id',
  `file` varchar(225) NOT NULL COMMENT '文件',
  `sort` int(11) NOT NULL COMMENT '次序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `property_listing_image`
--

INSERT INTO `property_listing_image` (`id`, `property_listing_id`, `file`, `sort`) VALUES
(1, 22, 'http://192.168.93.112/uploads/房源图片/20260110/152822fb9c1fe119069304209549c2de.png', 1),
(2, 22, 'http://192.168.93.112/uploads/房源图片/20260110/51058b83e186b6dc45c6f1edb52c67ef.jpg', 2),
(3, 23, 'http://192.168.93.112/uploads/房源图片/20260110/417c850e97b896222076d652f6992210.png', 1),
(5, 25, 'http://192.168.93.112/uploads/房源图片/20260110/c267cda82a05604e6a16343e019118ed.png', 1),
(6, 25, 'http://192.168.93.112/uploads/房源图片/20260110/55cf21deee844546eab5b07ac2c27a82.png', 2),
(7, 26, '/media/sf_wwwroot/127.0.0.1/uploads/房源图片/20260121/d58793519afa70ea277e4a360fd64d0d.jpg', 1),
(8, 27, 'https://192.168.93.112/media/sf_wwwroot/127.0.0.1/uploads/房源图片/20260121/2fe02fe8df47916f45b93d125fb0aa02.jpg', 1),
(20, 24, 'http://192.168.93.112/uploads/房源图片/20260121/2409495a15cd63b6f94a5e7d1dba2c50.jpg', 1),
(21, 24, 'http://192.168.93.112/uploads/房源图片/20260121/166fb684587636ae6aca513bc543316a.png', 2),
(22, 41, 'http://192.168.93.112/uploads/房源图片/20260126/470fa3d34f7741d2f70860164e58bc11.png', 1),
(23, 29, 'http://192.168.93.112/uploads/房源图片/20260121/f6d258ce07bbc369b60ebf89b2ac198b.jpg', 1),
(24, 42, 'http://192.168.93.112/uploads/房源图片/20260130/f6ec7078802103503a4fa4465ca51ca3.png', 1),
(25, 42, 'http://192.168.93.112/uploads/房源图片/20260130/a31b6130d658e2c03f99007ba4bca880.png', 2);

-- --------------------------------------------------------

--
-- 表的结构 `property_listing_order`
--

CREATE TABLE `property_listing_order` (
  `id` int(11) NOT NULL COMMENT 'id',
  `property_listing_id` int(11) NOT NULL COMMENT '主表id',
  `type` text NOT NULL COMMENT '商品名',
  `trade_no` varchar(225) NOT NULL COMMENT '订单号',
  `openid` varchar(225) NOT NULL COMMENT '账号',
  `status` tinyint(1) DEFAULT NULL COMMENT '支付状态',
  `create_time` int(11) NOT NULL COMMENT '下单时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `property_listing_order`
--

INSERT INTO `property_listing_order` (`id`, `property_listing_id`, `type`, `trade_no`, `openid`, `status`, `create_time`) VALUES
(22, 21, '上架', '20251206171242606488', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1765012362),
(23, 22, '上架', '20260110152124336793', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768029686),
(24, 23, '上架', '20260110152709218731', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768030030),
(25, 24, '上架', '20260110153021216223', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1, 1768030222),
(26, 25, '上架', '20260110153922361466', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768030763),
(27, 26, '上架', '20260121135543626752', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768974945),
(28, 27, '上架', '20260121135812468837', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768975093),
(29, 28, '上架', '20260121140232498548', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768975352),
(30, 29, '上架', '20260121140400154813', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1, 1768975440),
(31, 24, '延期', '20260121143547661251', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768977347),
(32, 24, '延期', '20260121143742475430', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768977463),
(33, 30, '上架', '20260121144757178950', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768978077),
(34, 31, '上架', '20260121151326247599', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768979606),
(35, 32, '上架', '20260121151643227527', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768979803),
(36, 33, '上架', '20260121152954719909', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768980595),
(37, 34, '上架', '20260121153608268082', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768980968),
(38, 35, '上架', '20260121154509432464', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768981509),
(39, 36, '上架', '20260121155638589138', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768982198),
(40, 37, '上架', '20260121160521727974', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768982722),
(41, 38, '上架', '20260121161322142404', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768983202),
(42, 39, '上架', '20260121161351261573', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768983231),
(43, 24, '延期', '20260121161532762608', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768983333),
(44, 24, '延期', '20260121162551588481', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768983951),
(45, 40, '上架', '20260121162634431451', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1, 1768983994),
(46, 24, '延期', '20260121163820454607', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1768984701),
(47, 40, '延期', '20260122145510635804', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 0, 1769064910),
(48, 41, '上架', '20260126152532433761', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1, 1769412333),
(49, 42, '上架', '20260130153708590115', 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1, 1769758630);

-- --------------------------------------------------------

--
-- 表的结构 `property_listing_video`
--

CREATE TABLE `property_listing_video` (
  `id` int(11) NOT NULL COMMENT 'id',
  `property_listing_id` int(11) NOT NULL COMMENT '父表id',
  `file` varchar(225) NOT NULL COMMENT '文件',
  `sort` int(11) NOT NULL COMMENT '次序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `property_listing_video`
--

INSERT INTO `property_listing_video` (`id`, `property_listing_id`, `file`, `sort`) VALUES
(1, 22, 'http://127.0.0.1/uploads/房源视频/20260110/0863042035bdab0f0a65bdfffa0638e5.mp4', 1),
(5, 24, 'http://192.168.93.112/uploads/房源视频/20260125/060016607cdb3b701bbf7e3480eccf67.mp4', 1),
(6, 42, 'http://192.168.93.112/uploads/房源视频/20260130/baa34fa37df605a2143993349430f17d.mp4', 1);

-- --------------------------------------------------------

--
-- 表的结构 `property_listing_visitor`
--

CREATE TABLE `property_listing_visitor` (
  `id` int(11) NOT NULL COMMENT '索引',
  `property_listing_id` int(11) NOT NULL COMMENT '房源id',
  `openid` text NOT NULL COMMENT '访客',
  `create_time` int(11) NOT NULL COMMENT '浏览时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `property_listing_visitor`
--

INSERT INTO `property_listing_visitor` (`id`, `property_listing_id`, `openid`, `create_time`) VALUES
(1, 40, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1769323868),
(2, 29, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1769325266),
(4, 41, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1769412428),
(5, 42, 'oV4BGvnVCKuBYfSxeuMWGwuMUW2w', 1769758660);

-- --------------------------------------------------------

--
-- 表的结构 `security_data_recycle`
--

CREATE TABLE `security_data_recycle` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='回收规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `security_data_recycle`
--

INSERT INTO `security_data_recycle` (`id`, `name`, `controller`, `controller_as`, `data_table`, `connection`, `primary_key`, `status`, `update_time`, `create_time`) VALUES
(1, '管理员', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', 1, 1770530411, 1770530411),
(2, '管理员日志', 'auth/AdminLog.php', 'auth/adminlog', 'admin_log', '', 'id', 1, 1770530411, 1770530411),
(3, '菜单规则', 'auth/Menu.php', 'auth/menu', 'menu_rule', '', 'id', 1, 1770530411, 1770530411),
(4, '系统配置项', 'routine/Config.php', 'routine/config', 'config', '', 'id', 1, 1770530411, 1770530411),
(5, '用户', 'Account.php', 'account', 'account', 'mysql', 'id', 1, 1770710138, 1770530411),
(6, '数据回收规则', 'security/DataRecycle.php', 'security/datarecycle', 'security_data_recycle', '', 'id', 1, 1770530411, 1770530411);

-- --------------------------------------------------------

--
-- 表的结构 `security_data_recycle_log`
--

CREATE TABLE `security_data_recycle_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `recycle_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '回收规则ID',
  `data` text COLLATE utf8mb4_unicode_ci COMMENT '回收的数据',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `is_restore` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否已还原:0=否,1=是',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据回收记录表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `security_sensitive_data`
--

CREATE TABLE `security_sensitive_data` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_fields` text COLLATE utf8mb4_unicode_ci COMMENT '敏感数据字段',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='敏感数据规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `security_sensitive_data`
--

INSERT INTO `security_sensitive_data` (`id`, `name`, `controller`, `controller_as`, `data_table`, `connection`, `primary_key`, `data_fields`, `status`, `update_time`, `create_time`) VALUES
(1, '管理员数据', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', '{\"username\":\"用户名\",\"mobile\":\"手机\",\"password\":\"密码\",\"status\":\"状态\"}', 1, 1770530411, 1770530411),
(2, '用户数据', 'Account.php', 'account', 'account', 'mysql', 'id', '{\"openid\":\"账号id\"}', 1, 1770710200, 1770530411),
(3, '管理员权限', 'auth/Group.php', 'auth/group', 'admin_group', '', 'id', '{\"rules\":\"权限规则ID\"}', 1, 1770530411, 1770530411);

-- --------------------------------------------------------

--
-- 表的结构 `security_sensitive_data_log`
--

CREATE TABLE `security_sensitive_data_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `sensitive_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '敏感数据规则ID',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_field` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改字段',
  `data_comment` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改项',
  `id_value` int(11) NOT NULL DEFAULT '0' COMMENT '被修改项主键值',
  `before` text COLLATE utf8mb4_unicode_ci COMMENT '修改前',
  `after` text COLLATE utf8mb4_unicode_ci COMMENT '修改后',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `is_rollback` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否已回滚:0=否,1=是',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='敏感数据修改记录' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `security_sensitive_data_log`
--

INSERT INTO `security_sensitive_data_log` (`id`, `admin_id`, `sensitive_id`, `data_table`, `connection`, `primary_key`, `data_field`, `data_comment`, `id_value`, `before`, `after`, `ip`, `useragent`, `is_rollback`, `create_time`) VALUES
(1, 1, 3, 'admin_group', '', 'id', 'rules', '权限规则ID', 4, '55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75', NULL, '192.168.93.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 0, 1770710351),
(2, 1, 3, 'admin_group', '', 'id', 'rules', '权限规则ID', 2, '1,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,77,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,89', NULL, '124.240.42.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 0, 1771750027);

-- --------------------------------------------------------

--
-- 表的结构 `test_build`
--

CREATE TABLE `test_build` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `keyword_rows` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `views` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '浏览量',
  `likes` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '有帮助数',
  `dislikes` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '无帮助数',
  `note_textarea` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `update_time` bigint(20) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(20) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='知识库表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `token`
--

CREATE TABLE `token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Token',
  `type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类型',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '过期时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户Token表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `token`
--

INSERT INTO `token` (`token`, `type`, `user_id`, `create_time`, `expire_time`) VALUES
('080b881be0cd1a75c894402db763dda616a376b5', 'admin-refresh', 1, 1770964228, 1773556228),
('1d41c9f19e046e075c28907ecd4901eb0af97cda', 'admin', 2, 1771750046, 1772009246),
('383a831a8ab9215e8d6577bdc86d056c03e590f7', 'admin-refresh', 2, 1771750046, 1774342046),
('50f1f6758e4cc6f7cce8cf0026c2b791a76d54a7', 'admin-refresh', 1, 1770534476, 1773126476),
('5bf4eafb4678c06bdd0fe0c2bfba1b4cd843be05', 'admin-refresh', 1, 1770531915, 1773123915);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分组ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '性别:0=未知,1=男,2=女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `money` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '余额',
  `score` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '积分',
  `last_login_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `login_failure` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `join_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加入IP',
  `join_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '加入时间',
  `motto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐（废弃待删）',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态:enable=启用,disable=禁用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `group_id`, `username`, `nickname`, `email`, `mobile`, `avatar`, `gender`, `birthday`, `money`, `score`, `last_login_time`, `last_login_ip`, `login_failure`, `join_ip`, `join_time`, `motto`, `password`, `salt`, `status`, `update_time`, `create_time`) VALUES
(1, 1, 'user', 'User', '18888888888@qq.com', '18888888888', '', 2, '2026-02-08', 0, 0, NULL, '', 0, '', NULL, '', '$2y$10$7epF6LJaWXpx71I7hpTpl.TD7vRoRRjVc.20JCPeWrt2AmdxHfc.C', '', 'enable', 1770530411, 1770530411);

-- --------------------------------------------------------

--
-- 表的结构 `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员组表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `user_group`
--

INSERT INTO `user_group` (`id`, `name`, `rules`, `status`, `update_time`, `create_time`) VALUES
(1, '默认分组', '*', 1, 1770530411, 1770530411);

-- --------------------------------------------------------

--
-- 表的结构 `user_money_log`
--

CREATE TABLE `user_money_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '变更余额',
  `before` int(11) NOT NULL DEFAULT '0' COMMENT '变更前余额',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员余额变动表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `user_rule`
--

CREATE TABLE `user_rule` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `type` enum('route','menu_dir','menu','nav_user_menu','nav','button') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:route=路由,menu_dir=菜单目录,menu=菜单项,nav_user_menu=顶栏会员菜单下拉项,nav=顶栏菜单项,button=页面按钮',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tab' COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `no_login_valid` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '未登录有效:0=否,1=是',
  `extend` enum('none','add_rules_only','add_menu_only') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员菜单权限规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `user_rule`
--

INSERT INTO `user_rule` (`id`, `pid`, `type`, `title`, `name`, `path`, `icon`, `menu_type`, `url`, `component`, `no_login_valid`, `extend`, `remark`, `weigh`, `status`, `update_time`, `create_time`) VALUES
(1, 0, 'menu_dir', '我的账户', 'account', 'account', 'fa fa-user-circle', 'tab', '', '', 0, 'none', '', 98, 1, 1770530411, 1770530411),
(2, 1, 'menu', '账户概览', 'account/overview', 'account/overview', 'fa fa-home', 'tab', '', '/src/views/frontend/user/account/overview.vue', 0, 'none', '', 99, 1, 1770530411, 1770530411),
(3, 1, 'menu', '个人资料', 'account/profile', 'account/profile', 'fa fa-user-circle-o', 'tab', '', '/src/views/frontend/user/account/profile.vue', 0, 'none', '', 98, 1, 1770530411, 1770530411),
(4, 1, 'menu', '修改密码', 'account/changePassword', 'account/changePassword', 'fa fa-shield', 'tab', '', '/src/views/frontend/user/account/changePassword.vue', 0, 'none', '', 97, 1, 1770530411, 1770530411),
(5, 1, 'menu', '积分记录', 'account/integral', 'account/integral', 'fa fa-tag', 'tab', '', '/src/views/frontend/user/account/integral.vue', 0, 'none', '', 96, 1, 1770530411, 1770530411),
(6, 1, 'menu', '余额记录', 'account/balance', 'account/balance', 'fa fa-money', 'tab', '', '/src/views/frontend/user/account/balance.vue', 0, 'none', '', 95, 1, 1770530411, 1770530411);

-- --------------------------------------------------------

--
-- 表的结构 `user_score_log`
--

CREATE TABLE `user_score_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(11) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint(16) UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员积分变动表' ROW_FORMAT=DYNAMIC;

--
-- 转储表的索引
--

--
-- 表的索引 `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `admin_group`
--
ALTER TABLE `admin_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `admin_group_access`
--
ALTER TABLE `admin_group_access`
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `admin_log`
--
ALTER TABLE `admin_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `admin_rule`
--
ALTER TABLE `admin_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- 表的索引 `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- 表的索引 `attachment`
--
ALTER TABLE `attachment`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `captcha`
--
ALTER TABLE `captcha`
  ADD PRIMARY KEY (`key`);

--
-- 表的索引 `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `crud_log`
--
ALTER TABLE `crud_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dataexport`
--
ALTER TABLE `dataexport`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dynamic`
--
ALTER TABLE `dynamic`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dynamic_image`
--
ALTER TABLE `dynamic_image`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dynamic_video`
--
ALTER TABLE `dynamic_video`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`version`);

--
-- 表的索引 `property_listing`
--
ALTER TABLE `property_listing`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `property_listing_favorites`
--
ALTER TABLE `property_listing_favorites`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `property_listing_image`
--
ALTER TABLE `property_listing_image`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `property_listing_order`
--
ALTER TABLE `property_listing_order`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `property_listing_video`
--
ALTER TABLE `property_listing_video`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `property_listing_visitor`
--
ALTER TABLE `property_listing_visitor`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `security_data_recycle`
--
ALTER TABLE `security_data_recycle`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `security_data_recycle_log`
--
ALTER TABLE `security_data_recycle_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `security_sensitive_data`
--
ALTER TABLE `security_sensitive_data`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `security_sensitive_data_log`
--
ALTER TABLE `security_sensitive_data_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `test_build`
--
ALTER TABLE `test_build`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`token`);

--
-- 表的索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_money_log`
--
ALTER TABLE `user_money_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_rule`
--
ALTER TABLE `user_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- 表的索引 `user_score_log`
--
ALTER TABLE `user_score_log`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `admin_group`
--
ALTER TABLE `admin_group`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `admin_log`
--
ALTER TABLE `admin_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=90;

--
-- 使用表AUTO_INCREMENT `admin_rule`
--
ALTER TABLE `admin_rule`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=177;

--
-- 使用表AUTO_INCREMENT `area`
--
ALTER TABLE `area`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `attachment`
--
ALTER TABLE `attachment`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=15;

--
-- 使用表AUTO_INCREMENT `crud_log`
--
ALTER TABLE `crud_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `dataexport`
--
ALTER TABLE `dataexport`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `dynamic`
--
ALTER TABLE `dynamic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引', AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `dynamic_image`
--
ALTER TABLE `dynamic_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引', AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `dynamic_video`
--
ALTER TABLE `dynamic_video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引';

--
-- 使用表AUTO_INCREMENT `property_listing`
--
ALTER TABLE `property_listing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=43;

--
-- 使用表AUTO_INCREMENT `property_listing_favorites`
--
ALTER TABLE `property_listing_favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引', AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `property_listing_image`
--
ALTER TABLE `property_listing_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=26;

--
-- 使用表AUTO_INCREMENT `property_listing_order`
--
ALTER TABLE `property_listing_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=50;

--
-- 使用表AUTO_INCREMENT `property_listing_video`
--
ALTER TABLE `property_listing_video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `property_listing_visitor`
--
ALTER TABLE `property_listing_visitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引', AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `security_data_recycle`
--
ALTER TABLE `security_data_recycle`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `security_data_recycle_log`
--
ALTER TABLE `security_data_recycle_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `security_sensitive_data`
--
ALTER TABLE `security_sensitive_data`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `security_sensitive_data_log`
--
ALTER TABLE `security_sensitive_data_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `test_build`
--
ALTER TABLE `test_build`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `user_money_log`
--
ALTER TABLE `user_money_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `user_rule`
--
ALTER TABLE `user_rule`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `user_score_log`
--
ALTER TABLE `user_score_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
