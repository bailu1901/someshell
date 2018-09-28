#!/bin/bash

##################
# 测试当前VMS版本
##################

#测试 URL
VMS_URL=$1

TEST_URL=$(curl $VMS_URL -s)
RET=$(echo "$TEST_URL" | grep -Po '(?<=s":)[0-9]+' )
echo RET=$RET
if [ $RET -eq 0 ];then
  exit 0
else
  
  exit 1
fi

