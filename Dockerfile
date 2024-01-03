FROM caddy:builder AS builder

# In China, you may need to use a proxy
# RUN go env -w GOPROXY=https://goproxy.cn,direct

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/dnspod \
    --with github.com/greenpau/caddy-security \
    --with github.com/greenpau/caddy-trace \
    --with github.com/caddyserver/transform-encoder

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir -p /var/www/static /data/logs

COPY caddy/Caddyfile /etc/caddy/Caddyfile
COPY caddy/static/favicon.ico /var/www/static/favicon.ico

ENV LOG_FILE=/data/logs/caddy.log
EXPOSE 80 443