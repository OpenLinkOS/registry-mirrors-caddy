#!/bin/bash

# 加载环境变量
source .env

# Caddy 的 Systemd 服务文件路径
CADDY_SERVICE_FILE="/lib/systemd/system/caddy.service"

# 构建新的 Environment 行内容
new_env="Environment=\"DOMAIN=$DOMAIN\" \"HOSTNAME=$HOSTNAME\" \"DNS_API_TOKEN=$DNS_API_TOKEN\""

# 检查并更新或添加 Environment 行
if grep -q "Environment=" "$CADDY_SERVICE_FILE"; then
    sed -i "/Environment=/c\\$new_env" "$CADDY_SERVICE_FILE"
else
    sed -i "/\[Service\]/a $new_env" "$CADDY_SERVICE_FILE"
fi

# 重新加载 Systemd 守护进程
if systemctl daemon-reload; then
    echo "Systemd daemon reloaded successfully."
else
    echo "Failed to reload Systemd daemon."
    exit 1
fi

# 覆盖拷贝 linkos 的 favicon 图标
mkdir -p /var/www/static
cp -f caddy/static/favicon.ico /var/www/static/favicon.ico
chmod 644 /var/www/static/favicon.ico

# 覆盖拷贝 Caddyfile 配置文件
cp -f caddy/Caddyfile /etc/caddy/Caddyfile

systemctl restart caddy