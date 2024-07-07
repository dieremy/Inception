FROM alpine:3.15.0

ENV NGINX_VERSION=1.20.2-r2

RUN	apk update && \
    apk add --no-cache \
    nginx=${NGINX_VERSION}

COPY containers/nginx/nginx.conf /etc/nginx/nginx.conf
COPY containers/nginx/certs/cert.crt /etc/nginx/ssl/cert.crt
COPY containers/nginx/certs/cert.key /etc/nginx/ssl/cert.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
