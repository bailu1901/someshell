#!/bin/bash
CURDIR=$(cd $(dirname $0); pwd)

#版本
VERSION=$1

#保存目录
SAVE_FILE=$2

#user
USER=root

#RSA
RSA_FILE=$CURDIR/id_rsa_pkg

#host
IP=172.25.129.54

#拷贝源文件
SRC_FILE=/data/work/walle/package/S-Project/server_update/$VERSION.tar.gz
SRC_DIFFFILE=/data/work/walle/package/S-Project/server_update/$VERSION.diff.tar.gz

echo SRC_FILE=$SRC_FILE

#开始拷贝
scp -i $RSA_FILE $USER@$IP:$SRC_FILE $SAVE_FILE
if [ $? -eq 0 ];then
  	echo scp ok
else
	echo scp failed
  	exit 1
fi

#这步骤允许失败，diff文件不一定存在
scp -i $RSA_FILE $USER@$IP:$SRC_DIFFFILE $SAVE_FILE

#
exit 0