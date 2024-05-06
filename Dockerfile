FROM docker.io/library/caddy:alpine AS builder

COPY ./public /usr/share/caddy

WORKDIR /usr/share/caddy

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
