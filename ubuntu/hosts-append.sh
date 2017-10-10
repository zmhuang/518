#!/bin/bash
set -e
#set -x

FILE=hosts

cd /tmp

fromdos $FILE
echo >> $FILE

# 2、添加一些条目


hn=`hostname`
echo -e "127.0.0.1\t$hn" >> $FILE

# dl 应当使用 nslookup 结果，以提升下载速度
#for i in dl.google.com dl.l.google.com dl-ssl.google.com;
#do
#sed -i "/$i/ d" $FILE
#echo -e "220.255.2.153	$i" >> $FILE
#done

sudo cp $FILE /etc/hosts
