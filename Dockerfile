FROM docker.io/library/caddy:alpine

COPY ./public /usr/share/caddy

WORKDIR /usr/share/caddy
