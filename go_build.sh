#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"

GO_BUILD() 
{

echo "=========================================GO_BUILD begin"

GOPATH=$1
PROJ=$2
BUILD_OS=$3
OUT_DIR=$4

echo GOPATH=$GOPATH
echo PROJ=$GOPATH/src/$PROJ
echo OUT_DIR=$OUT_DIR
echo BUILD_OS=$BUILD_OS

go env

echo 


cd $OUT_DIR
export GOPATH=$GOPATH
GOOS=$BUILD_OS GOARCH=amd64 go build -v -a -gcflags "-N -l"  $PROJ
echo out_put=$PROJ
echo "=========================================GO_BUILD end"

}