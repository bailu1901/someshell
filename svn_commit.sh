#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"

SVN_COMMIT()
{
echo "=========================================SVN_COMMIT begin"
SVN_DIR=$1
COMMIT_MSG=$2

cd $SVN_DIR
svn add * --force
svn commit -m $COMMIT_MSG

echo "=========================================SVN_COMMIT end"
}
