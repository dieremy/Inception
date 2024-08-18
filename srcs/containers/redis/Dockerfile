FROM alpine:3.18.0

ENV REDIS_VERSION=7.0.15-r0

######## ? ########
RUN apk update && \
    apk add --no-cache \
    redis=${REDIS_VERSION}
#     sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g"  /etc/redis.conf && \
#     sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g"  /etc/redis.conf && \
#     echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf
# ######## ? ########

EXPOSE 6379

CMD [ "redis-server" , "/etc/redis.conf" ]
