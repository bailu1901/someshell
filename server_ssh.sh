#!/bin/bash

##################
# 更新并重启游戏逻辑服务器
##################

CURDIR=$(cd $(dirname $0); pwd)

#user
USER=$1

#RSA
RSA_FILE=$2

#host
IP=$3

#版本号
VERSION=$4

#节点ID
NODE=$5

#工作目录
WORKPATH=$6

#扩展参数
PARAM=$7

FULLPATH=$CURDIR/$VERSION.tar.gz
FILE=${FULLPATH##*/} 

echo USER=$USER
echo IP=$IP
echo RSA_FILE=$RSA_FILE
echo VERSION=$VERSION
echo NODE=$NODE
echo WORKPATH=$WORKPATH
echo FULLPATH=$FULLPATH
echo FILE=$FILE

#下载文件
sh $CURDIR/download_pkg.sh $VERSION $FULLPATH
if [ $? -eq 0 ];then
  	echo download ok
else
	echo download failed
  	exit 1
fi

#上传到目标机器
scp -i $RSA_FILE $FULLPATH $USER@$IP:$WORKPATH
if [ $? -eq 0 ];then
  	echo upload ok
else
	echo upload failed
  	exit 1
fi


#ssh上去做版本替换
ssh -i $RSA_FILE $USER@$IP "cd $WORKPATH \
&& pwd \
&& tar -xzf $FILE \
&& echo -----------------------tar over \
&& rm -rf ./yoozoo/S-Project/version/backend/static/config \
&& echo -----------------------remove config \
&& cp -r ./yoozoo/S-Project/version/backend/* $WORKPATH/ \
&& echo -----------------------copy over \
&& rm -rf ./yoozoo \
&& rm -rf $FILE \
&& echo finish" 
if [ $? -eq 0 ];then
  	echo ssh ok
else
	echo ssh failed
  	exit 1
fi

rm -rf $FULLPATH

ssh -i $RSA_FILE $USER@$IP "bash -s -- $args"  < $CURDIR/server.sh $WORKPATH/static/bin $NODE "$PARAM"
if [ $? -eq 0 ];then
  	echo restart server ok
else
	echo restart server ok failed
  	exit 1
fi