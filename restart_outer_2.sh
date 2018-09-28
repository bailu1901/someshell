#!/bin/bash

##################
# 重启外网游戏逻辑服务器2
##################

CURDIR=$(cd $(dirname $0); pwd)

#版本
VERSION=$1

#节点ID
NODE=2

#user
USER=root

#RSA
RSA_FILE=$CURDIR/id_rsa_outer

#host
IP=www.zlin.top

#VMS版本目录
WORKPATH=/data/work/server_mobile_2
#WORKPATH=/data/work/server_test

sh $CURDIR/server_ssh.sh $USER $RSA_FILE $IP $VERSION $NODE $WORKPATH '-serverlisturl=http://127.0.0.1:8888/serverlist'
if [ $? -eq 0 ];then
  	echo ok
else
	echo failed
  	exit 1
fi



