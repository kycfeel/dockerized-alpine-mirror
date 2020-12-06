FROM alpine:3.12

RUN apk update && apk add rsync mqtt-exec && \
    mkdir /alpine-mirror

COPY src/alpine-mirror /etc/periodic/hourly/alpine-mirror 

RUN chmod +x /etc/periodic/hourly/alpine-mirror

COPY src/rsync.conf /etc/rsyncd.conf

WORKDIR /alpine-mirror

ENTRYPOINT sh /etc/periodic/hourly/alpine-mirror && exec crond -f
