#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"

SVN_REVERT()
{
echo "=========================================SVN_REVERT begin"
SVN_DIR=$1

echo $SVN_DIR

cd $SVN_DIR
svn cleanup
svn revert -R -q ./
svn up --force --accept tc	

echo "=========================================SVN_REVERT end"
}
