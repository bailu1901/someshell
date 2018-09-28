#!/bin/bash

##################
# 修改内网VMS线上版本
##################

CURDIR=$(cd $(dirname $0); pwd)

#版本
VERSION=$1

#版本名字
VERSION_NAME=$2

#user
USER=root

#RSA
RSA_FILE=$CURDIR/id_rsa_inner

#host
IP=172.25.135.185

#要被拷贝的文件
FULLPATH=$CURDIR/$VERSION.tar.gz

#VMS配置目录
VMSCONF_PATH=/data/work/www/vms/configs
#VMSCONF_PATH=/data/work/test


if [ $# -ne 2 ]; then
   echo "参数格式错误，参数1(文件名) 参数2(版本名) 参数3(版本号)"
   exit -1
fi

echo USER=$USER
echo IP=$IP
echo RSA_FILE=$RSA_FILE
echo VERSION=$VERSION
echo VERSION_NAME=$VERSION_NAME
echo VMSCONF_PATH=$VMSCONF_PATH

#执行切换
sh $CURDIR/switch_version.sh $USER $RSA_FILE $IP $VERSION $VERSION_NAME $VMSCONF_PATH
if [ $? -eq 0 ];then
  echo switch ok
else
  echo switch failed
  exit 1
fi


exit 0