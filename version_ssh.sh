#!/bin/bash
#参数1:版本名  参数2:版本号 参数3:目标ip 参数4(可选):修改的目标文件的路径

CURDIR=$(cd $(dirname $0); pwd)

#版本名 例如 demo ios android ios_dev
VERSIONNAME=$1

#版本号 瓦利产出
VERSIONCODE=$2

#host 
IP=$3

#VMS版本配置目录
VERSIONFILE=/data/work/www/vms/configs/online_version.php


if [ $# -eq 4 ]; then
	VERSIONFILE=$4
fi

#user
USER=root

#RSA
RSA_FILE=$CURDIR/id_rsa_inner

if [ "${IP}" = "www.zlin.top" ]; then
    RSA_FILE=$CURDIR/id_rsa_outer
else
    RSA_FILE=$CURDIR/id_rsa_inner
fi


echo VERSIONFILE=$VERSIONFILE
echo VERSIONNAME=$VERSIONNAME
echo VERSIONCODE=$VERSIONCODE
echo IP=$IP
echo USER=$USER
echo RSA_FILE=$RSA_FILE

echo begin change version
ssh -i $RSA_FILE $USER@$IP "bash -s -- $args"  < $CURDIR/version.sh $VERSIONFILE $VERSIONNAME $VERSIONCODE
#ssh -i id_rsa_inner root@172.25.135.185 "bash -s -- $args"  < $CURDIR/version.sh $VERSIONFILE $VERSIONNAME $VERSIONCODE
#ssh -i id_rsa_inner root@172.25.135.185 "bash -s -- $args" < test.sh $1 $2
echo finish

if [ $? -eq 0 ];then
  	echo ssh ok
else
	echo -----------------------ssh failed
  	exit 1
fi
