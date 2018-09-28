CURDIR="$( cd "$( dirname "$0"  )" && pwd  )"

export GOPATH=E:/Work/mhserver/static
echo GOPATH=$GOPATH
SVN_DIR=E:/Work/server_win

cd $GOPATH
BUILD_VERSION=win_test
BUILD_TIME=$(date "+%F %T")
COMMIT_SHA1=$(git rev-parse HEAD )

go env

echo "========================================="
echo "update code ......"
cd $GOPATH
git reset --hard
git pull
echo "========================================="

echo "========================================="
echo "svn cleanup"
cd $SVN_DIR
svn cleanup
svn revert -R -q ./
svn up --force --accept tc
echo "========================================="


echo "========================================="
echo "build service ......"
go clean
cd $SVN_DIR/static/bin
go build -gcflags "-N -l" -ldflags "           \
    -X 'version.BuildVersion=${BUILD_VERSION}' \
    -X 'version.BuildTime=${BUILD_TIME}'       \
    -X 'version.CommitID=${COMMIT_SHA1}'       \
    "                                          \
    -v service
echo "========================================="

echo "========================================="
echo "copy ..."
cp $GOPATH/data/*.*  $SVN_DIR/static/data
cd $SVN_DIR/static/data
svn add * --force
echo "========================================="

echo "========================================="
cd $SVN_DIR
echo "commit ......"
svn commit -m $COMMIT_SHA1
echo "========================================="