#!/bin/sh -e
#
# $KCPTUN_PROG from Dockerfile
#

function kcptun_exit
{
    echo "exit kcptun"

    killall $KCPTUN_PROG
}

trap 'kcptun_exit' TERM

OPTS=

if [ "$KCPTUN_TYPE" = "server" ]; then
    [ $KCPTUN_LISTEN ] && OPTS="$OPTS -l $KCPTUN_LISTEN" 
    [ $KCPTUN_TARGET ] && OPTS="$OPTS -t $KCPTUN_TARGET" 
else
    [ $KCPTUN_LOCALADDR ] && OPTS="$OPTS -l $KCPTUN_LOCALADDR" 
    [ $KCPTUN_REMOTEADDR ] && OPTS="$OPTS -r $KCPTUN_REMOTEADDR" 
fi

[ $KCPTUN_MODE ] && OPTS="$OPTS --mode $KCPTUN_MODE" 
[ $KCPTUN_CRYPT ] && OPTS="$OPTS --crypt $KCPTUN_CRYPT" 

$KCPTUN_PROG $OPTS &

echo "kcptun(pid: $!) runing with: $KCPTUN_PROG $OPTS"

wait $!