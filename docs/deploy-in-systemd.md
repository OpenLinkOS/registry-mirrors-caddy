# Deploy registry mirror with caddy in systemd

该部署直接在服务器上使用 systemd 管理运行 caddy，具有较好稳定性和性能，适合独占部署以及高性能部署场景。





## 部署要求

端口要求：:::80、:::443、127.0.0.1:2019 端口未占用

系统要求：Debian，其余版本需自行调整兼容

架构要求：x86 / amd64





## 部署步骤

```bash
# 克隆部署仓库
git clone https://github.com/OpenLinkOS/registry-mirrors-caddy.git

# 进入部署项目，创建环境变量
cd registry-mirrors-caddy/ && cp .env.sample .env

# 修改环境变量为真实环境变量
# nano .env

# 安装 caddy - debian 直接执行，其余版本结合 deploy-caddy.sh 脚本中内容进行调整
bash deploy-caddy.sh

# 部署 registry mirrors 应用
bash deploy-registry-mirrors.sh
```





## 卸载步骤

```bash
# 停止并禁用 Caddy 服务
systemctl stop caddy
systemctl disable caddy

# 删除 Caddy 相关的文件和目录
rm -rf /var/www/static /etc/caddy/Caddyfile /var/log/caddy

# 卸载 Caddy 软件包
apt remove --purge caddy

# （可选）清除无用的包依赖
apt autoremove
```

