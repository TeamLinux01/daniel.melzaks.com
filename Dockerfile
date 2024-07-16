FROM docker.io/chainguard/hugo:latest-dev AS builder

COPY ./ /hugo

RUN hugo --gc --minify

FROM docker.io/library/caddy:alpine

COPY --from=builder /hugo/public/ /usr/share/caddy/

WORKDIR /usr/share/caddy
