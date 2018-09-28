#!/bin/bash
echo service working

WORKPATH=$1
NODE=$2
PARAM=$3
SERVER_NAME=service_$NODE
let PORT=60000
WEBPORT=$[$PORT+ $NODE]
cd $WORKPATH

echo WORKPATH=$WORKPATH
echo NODE=$NODE
echo SERVER_NAME=$SERVER_NAME
echo PARAM=$PARAM

sh cmd.sh stop $SERVER_NAME
rm -rf $SERVER_NAME
cp service $SERVER_NAME
sh cmd.sh start $SERVER_NAME -name=logic -node=$NODE -web=:$WEBPORT #$PARAM
