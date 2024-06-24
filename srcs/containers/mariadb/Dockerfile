FROM alpine:3.15

ARG	DB_NAME \
	DB_USER \
	DB_PSWD \
	DB_ROOT

RUN apk update && apk add --no-cache mariadb mariadb-client

EXPOSE 3306
