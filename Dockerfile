FROM docker.io/chainguard/hugo:latest as builder

RUN hugo --gc --minify

FROM docker.io/library/caddy:alpine

COPY --from=builder /hugo/public /usr/share/caddy

WORKDIR /usr/share/caddy
