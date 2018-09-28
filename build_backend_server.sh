#工程目录
GIT_DIR=$1

#输出目录
OUTPUT_DIR=$2

#服务器代码版本号
SERVER_VER=$3

#csv 目录
CSV_DIR=$4

#GOPATH
GOPATH=$GIT_DIR/static

#代码版本号编入可执行程序
export SERVER_VERSION=$SERVER_VER

echo GIT_DIR=$GIT_DIR
echo GOPATH=$GOPATH
echo OUTPUT_DIR=$OUTPUT_DIR
echo SERVER_VERSION=$SERVER_VER
echo CSV_DIR=$CSV_DIR


cd $GOPATH
version=$(git rev-parse HEAD)
echo $version

#编译服务器
echo "=========================================make begin"
export GOOS=linux
go env
make service
if [ $? -eq 0 ];then
  	echo "=========================================make over"
else
	echo "=========================================make failed"
  	exit 1
fi

#拷贝
mkdir $OUTPUT_DIR/static

#拷贝bin
echo "=========================================copy begnin"
cp -r $GIT_DIR/dynamic $OUTPUT_DIR
cp -r $GOPATH/config $OUTPUT_DIR/static
cp -r $GOPATH/bin  $OUTPUT_DIR/static
echo "=========================================copy over"

#拷贝表格csv->json脚本工具
echo "=========================================convert begnin"
cp -r $CSV_DIR $OUTPUT_DIR/static/data
echo "=========================================convert over"

echo>>$OUTPUT_DIR/$SERVER_VER

exit 0