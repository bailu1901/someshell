#!/bin/bash

##################
# 修改VMS线上版本
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

#版本名字
VERSION_NAME=$5

#VMS配置目录
VMSCONF_PATH=$6

if [ $# -ne 6 ]; then
   echo "参数格式错误，参数1(文件名) 参数2(版本名) 参数3(版本号)"
   exit -1
fi

FULLPATH=$CURDIR/$VERSION.tar.gz
FILE=${FULLPATH##*/} 

echo USER=$USER
echo IP=$IP
echo RSA_FILE=$RSA_FILE
echo VERSION=$VERSION
echo VERSION_NAME=$VERSION_NAME
echo VMSCONF_PATH=$VMSCONF_PATH
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
scp -i $RSA_FILE $FULLPATH $USER@$IP:$VMSCONF_PATH
if [ $? -eq 0 ];then
  	echo upload ok
else
	echo upload failed
  	exit 1
fi

#ssh上去做版本替换
ssh -i $RSA_FILE $USER@$IP "cd $VMSCONF_PATH \
&& pwd \
&& tar -xzf $FILE \
&& echo -----------------------tar over \
&& cp -r ./yoozoo/S-Project/filecache/config/vms/* $VMSCONF_PATH \
&& echo -----------------------copy vms config over \
&& rm -rf ./yoozoo \
&& rm -rf $FILE \
&& echo finish" 

if [ $? -eq 0 ];then
  	echo upload ok
else
	echo upload failed
  	exit 1
fi


ssh -i $RSA_FILE $USER@$IP "bash -s -- $args"  < $CURDIR/version.sh $VMSCONF_PATH/online_version.php $VERSION_NAME $VERSION
if [ $? -eq 0 ];then
    echo switch version ok
else
  echo switch version failed
    exit 1
fi

rm -rf $FULLPATH

exit 0