FROM alpine:3.16.0

ENV NGINX_VERSION=1.22.1-r1

RUN	apk update && \
    apk add --no-cache \
    nginx=${NGINX_VERSION}

COPY containers/nginx/nginx.conf /etc/nginx/nginx.conf
COPY containers/nginx/certs/cert.crt /etc/nginx/ssl/cert.crt
COPY containers/nginx/certs/cert.key /etc/nginx/ssl/cert.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
