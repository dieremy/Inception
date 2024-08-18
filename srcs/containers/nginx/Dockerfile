FROM alpine:3.18.0

ENV NGINX_VERSION=1.24.0-r7

RUN apk update && \
    apk add --no-cache \
    nginx=${NGINX_VERSION}

COPY nginx.conf /etc/nginx/nginx.conf
COPY certs/cert.crt /etc/nginx/ssl/cert.crt
COPY certs/cert.key /etc/nginx/ssl/cert.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
