CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
TOOLS_ROOT=E:/Work/build_script/script
GOPATH=E:/Work/linux_server/build_server/static
SVN_DIR=E:/Work/linux_server/server_linux
TAG=$Branch
PROJ=service
OUT_DIR=$SVN_DIR/static/bin
#BUILD_OS=$Platform
BUILD_OS=linux


if [ $TAG == 'tag' ]; then 
	TAG=$Tag
fi

echo CURRENT_DIR=$CURRENT_DIR
echo TOOLS_ROOT=$TOOLS_ROOT
echo GOPATH=$GOPATH
echo SVN_DIR=$SVN_DIR
echo TAG=$TAG
echo PROJ=$GOPATH/src/$PROJ
echo OUT_DIR=$OUT_DIR
echo BUILD_OS=$BUILD_OS

source $TOOLS_ROOT/svn_revert.sh
source $TOOLS_ROOT/svn_commit.sh
source $TOOLS_ROOT/copy.sh
source $TOOLS_ROOT/go_build.sh
source $TOOLS_ROOT/update_git.sh

SVN_REVERT $SVN_DIR
GIT_OPT $GOPATH $TAG
GO_BUILD $GOPATH $PROJ $BUILD_OS $OUT_DIR
COPY $GOPATH/data  $SVN_DIR/static/data

cd $GOPATH
version=$(git rev-parse HEAD)
echo $version

SVN_COMMIT $SVN_DIR $version