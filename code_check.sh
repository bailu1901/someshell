CURDIR="$( cd "$( dirname "$0"  )" && pwd  )"
export GOPATH=E:/Work/mhserver_codecheck/static
echo GOPATH=$GOPATH

cd $GOPATH
git reset --hard
git pull

dir=($GOPATH/src/logic $GOPATH/src/battle)
for i in ${dir[@]}
do
	echo checking $i 
	echo ------------------------------------------------------
	if gometalinter --disable=gosec --disable=errcheck --disable=golint --disable=gocyclo --exclude=test --exclude=luajit --errors $i/...; then
		echo ok
	else
		echo error
        return 1
	fi
	
	#gometalinter.exe --disable=gosec --disable=errcheck --disable=golint --disable=gocyclo --exclude=test --errors $i
	echo ------------------------------------------------------
	echo
done
