FROM docker.io/chainguard/hugo:latest-dev as builder

COPY ./ /hugo

RUN hugo -c /hugo -d /public --gc --minify

FROM docker.io/library/caddy:alpine

COPY --from=builder /public /usr/share/caddy

WORKDIR /usr/share/caddy
