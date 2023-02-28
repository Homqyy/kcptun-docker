# syntax=docker/dockerfile:1
FROM alpine

ARG TARGETOS \
    TARGETARCH \
    TARGETVARIANT \
    TYPE=server

ENV KCPTUN_PROG=/bin/kcptun
ENV KCPTUN_TYPE=$TYPE

COPY ./src/${TARGETARCH}/${TARGETVARIANT}/kcptun_${TYPE}_linux /bin/kcptun
COPY ./start.sh /bin/start

RUN chmod +x /bin/start /bin/kcptun

LABEL cn.homqyy.docker.project=kcptun
LABEL cn.homqyy.docker.type=release
LABEL cn.homqyy.docker.author=homqyy
LABEL cn.homqyy.docker.email=yilupiaoxuewhq@163.com

ENTRYPOINT ["start"]
