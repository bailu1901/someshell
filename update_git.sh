#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"


GIT_OPT() 
{

echo "=========================================GIT_OPT begin"

GIT_REPO=$1
TAG=$2

echo GIT_REPO=$GIT_REPO
echo TAG=$TAG



cd $GIT_REPO
git reset --hard HEAD
case $TAG in
  master)
    git checkout $TAG
    git reset --hard origin/master
    git pull
    ;;
  release)
    git checkout $TAG
    git reset --hard origin/release
    git pull
    ;;
  develop)
    git checkout $TAG
    git reset --hard origin/develop
    git pull
    ;;
  *)
    git reset --hard $TAG
    ;;
esac

echo version= & git rev-parse HEAD

echo "=========================================GIT_OPT end"


}