#!/bin/bash

DIR="$( cd "$( dirname "$0"  )" && pwd  )"
export GOPATH=$DIR/..
echo GOPATH=$GOPATH

go build -gcflags='-N -l' battle
echo build battle ok

IP=172.25.133.78
let PORT=55080
let INSTANCE=3
let DEBUG_PORT=2345

for((i=0;i<$INSTANCE;i++));
do
port=$[$PORT + $i]
addr=$IP:$port
echo $addr

#start dlv --headless=true --api-version=2 --listen=:$[$DEBUG_PORT + $i] --log exec ./battle.exe -- -id=$port -log= -addr=$addr
start ./battle --id=$port --log= --addr=$addr
done  

# dlv attach --headless=true --api-version=2 --log --listen=:2345