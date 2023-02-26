FROM alpine

ARG TARGETOS=linux \
    TARGETARCH=amd64 \
    TYPE=server

ENV KCPTUN_PROG=/bin/kcptun
ENV KCPTUN_TYPE=$TYPE

COPY ./src/${TARGETARCH}/${TYPE}_linux_${TARGETARCH} /bin/kcptun
COPY ./start.sh /bin/start

RUN chmod +x /bin/start /bin/kcptun

LABEL cn.homqyy.docker.project=kcptun
LABEL cn.homqyy.docker.type=release
LABEL cn.homqyy.docker.author=homqyy
LABEL cn.homqyy.docker.email=yilupiaoxuewhq@163.com

ENTRYPOINT ["start"]
