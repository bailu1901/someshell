#!/bin/bash
#标量1=表示文件名
#变量2=表示版本的名字
#变量3=表示版本的版本号

if [ $# -ne 3 ]; then
   echo "参数格式错误，参数1(文件名) 参数2(版本名) 参数3(版本号)"
   exit -1
fi

filename=${1}
versionname=${2}
versioncode=${3}
echo "文件名是 ${filename}"
echo "版本名是 ${versionname}"
echo "版本号是 ${versioncode}"

echo "开始格式化文件"
astr=$( cat ${filename} | tr '\r' ' ' | tr '\n' ' ')
echo "格式化后 = ${astr}"

hasfound=0
s1=\'${versionname}\'
s2=\'${versionname}\',
v=" "\'version\'' => '\'${versioncode}\'
a="'all' => array("

if [[ ${astr} =~ ${s1} ]] && [[ ${astr} =~ ${s2} ]]
then
    hasfound=1
    echo "查找到已有的渠道"
else
    echo "没有查找到已有的渠道"
fi

if [ ${hasfound} -eq 1 ]; then
    str0=${astr#*${s2}}
    newstr=${astr%${s2}*}${s2}${v}\)${str0#*)}
    echo "newstr = ${newstr}"
    echo “替换渠道旧版本”
else
    str0=${astr#*${a}}
    newv=" 'newv' => array( 'upgrade_path' => 'newv', 'version' => '0', ),"

    newv="${newv//newv/${versionname}}"
    newv="${newv//0/${versioncode}}"
    newstr="${astr%${a}*}${a}${newv}${str0}"
    echo "newstr = ${newstr}"
    echo "添加新渠道版本"
fi

echo ${filename}
echo ${newstr} > ${filename}

