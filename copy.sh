#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"

COPY()
{
echo "=========================================COPY begin"

SRC_DIR=$1
DES_DIR=$2

cp $SRC_DIR/* $DES_DIR

echo "=========================================COPY end"
}
