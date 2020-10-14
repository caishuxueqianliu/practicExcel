#!/bin/sh
filepath=$1
key=$2

filedir=${filepath%/*}
filename=${filepath%.*}
filename=${filename##*/}
fileext=${filepath##*.}

filedir=`md5 -q -s $filedir`
filename=`md5 -q -s $filename`


filedir=`md5 -q -s "$filedir$key"`
filename=`md5 -q -s "$filename$key"`

echo $filedir/$filename.$fileext

if [ -d $filedir ];then
	open $filedir
fi