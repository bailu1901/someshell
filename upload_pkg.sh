#!/bin/bash
CURDIR=$(cd $(dirname $0); pwd)

#user
USER=$1

#RSA
RSA_FILE=$2

#host
IP=$3

#要被拷贝的文件
FULLPATH=$4
FILE=${FULLPATH##*/} 

#版本目录
VERSION_PATH=$5

#工作目录
WORK_DIR=$VERSION_PATH

echo USER=$USER
echo IP=$IP
echo RSA_FILE=$RSA_FILE
echo FULLPATH=$FULLPATH
echo FILE=$FILE
echo VERSION_PATH=$VERSION_PATH
echo VMSCONF_PATH=$VMSCONF_PATH

if [ ! $FILE ]; then
	echo 'input a file like xxx.tar.gz'
	exit 1
fi

#upload
scp -i $RSA_FILE $FULLPATH $USER@$IP:$WORK_DIR
if [ $? -eq 0 ];then
  	echo -----------------------copy ok
else
	echo -----------------------copy failed
  	exit 1
fi


#ssh
ssh -i $RSA_FILE $USER@$IP "cd $WORK_DIR \
&& pwd \
&& tar -xzf $FILE \
&& echo -----------------------tar over \
&& cp -r ./yoozoo/S-Project/version/versioninfo/* $VERSION_PATH \
&& echo -----------------------copy version over \
&& rm -rf ./yoozoo \
&& rm -rf $FILE \
&& echo -----------------------remove temp folder over \
&& echo finish" 

if [ $? -eq 0 ];then
  	echo ssh ok
else
	echo -----------------------ssh failed
  	exit 1
fi