#!/bin/bash

##################
# 上传VMS版本文件到内网机器
##################

CURDIR=$(cd $(dirname $0); pwd)

#版本
VERSION=$1

#user
USER=root

#RSA
RSA_FILE=$CURDIR/id_rsa_inner

#host
IP=172.25.135.185

#要被拷贝的文件
FULLPATH=$CURDIR/$VERSION.tar.gz

#VMS版本目录
VERSION_PATH=/data/work/gameroot/version/versioninfo
#VERSION_PATH=/data/work/test

#下载
sh $CURDIR/download_pkg.sh $VERSION $FULLPATH
if [ $? -eq 0 ];then
  	echo download ok
else
	echo download failed
  	exit 1
fi

#上传到目标机器
sh $CURDIR/upload_pkg.sh $USER $RSA_FILE $IP $FULLPATH $VERSION_PATH
if [ $? -eq 0 ];then
  	echo upload done!
else
	echo upload failed
  	exit 1
fi

rm -rf $FULLPATH
