#!/bin/bash

##################
# 重启内网游戏逻辑服务器
##################

CURDIR=$(cd $(dirname $0); pwd)

#版本
VERSION=$1

#节点ID
NODE=1011

#user
USER=root

#RSA
RSA_FILE=$CURDIR/id_rsa_inner

#host
IP=172.25.135.185

#VMS版本目录
WORKPATH=/data/work/server_dev_mobile_1011
#WORKPATH=/data/work/server_test

sh $CURDIR/server_ssh.sh $USER $RSA_FILE $IP $VERSION $NODE $WORKPATH
if [ $? -eq 0 ];then
  	echo ok
else
	echo failed
  	exit 1
fi



