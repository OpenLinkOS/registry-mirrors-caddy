# 安装 caddy
# 参考文档：https://caddyserver.com/docs/install
# 下方为 debian 系统安装命令
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

# 安装带有插件的 caddy
# 配置启用的插件：caddy-dns/cloudflare、caddyserver/transform-encoder、greenpau/caddy-security、greenpau/caddy-trace、caddy-dns/dnspod
# 访问该链接获取最新版本，需要注意选择正确的系统架构：https://caddyserver.com/download?package=github.com%2Fcaddy-dns%2Fcloudflare&package=github.com%2Fcaddyserver%2Ftransform-encoder&package=github.com%2Fgreenpau%2Fcaddy-security&package=github.com%2Fgreenpau%2Fcaddy-trace&package=github.com%2Fcaddy-dns%2Fdnspod
# 下方为 linux amd64 系统安装命令，使用2023年12月25日版本
curl -L "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fcaddy-dns%2Fcloudflare&p=github.com%2Fcaddyserver%2Ftransform-encoder&p=github.com%2Fgreenpau%2Fcaddy-security&p=github.com%2Fgreenpau%2Fcaddy-trace&p=github.com%2Fcaddy-dns%2Fdnspod&idempotency=98092184687710" -o caddy_temp
chmod +x caddy_temp
sudo mv caddy_temp /usr/bin/caddy