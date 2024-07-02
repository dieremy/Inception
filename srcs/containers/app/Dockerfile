FROM alpine:3.15.0
########### ? ###########
FROM python:3.9-alpine3.15
########### ? ###########

ENV NGINX_VERSION=nginx:1.22.0-r1

RUN	apk update && \
    apk add --no-cache \
    nginx=${NGINX_VERSION}

################################ TODO Check: evaluate the case of scripting or giving the setting by default
RUN echo "server {" > /etc/nginx/http.d/default.conf && \
    echo "root    /var/www;" >> /etc/nginx/http.d/default.conf && \
    echo "location / {" >> /etc/nginx/http.d/default.conf && \
    echo "    try_files \$uri /index.html;" >> /etc/nginx/http.d/default.conf && \
    echo "}}" >> /etc/nginx/http.d/default.conf
################################

COPY container/app/* /var/www/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]