# 使用官方 PHP + Apache 环境
FROM php:8.2-apache

# 设置时区
ENV TZ=Asia/Shanghai

# 设置工作目录（Apache 默认目录）
WORKDIR /www/html

# 拷贝项目到容器中
COPY . /www/html

# 安装 PHP 常用扩展（ThinkPHP 需要）
RUN docker-php-ext-install pdo_mysql mbstring exif

# 开启 Apache Rewrite 模块（ThinkPHP 伪静态）
RUN a2enmod rewrite

# 暴露端口
EXPOSE 80
