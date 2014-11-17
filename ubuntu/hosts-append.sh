#!/bin/bash
set -e
set -x

cd /tmp

FILE=hosts

# 1、下载 hosts 文件
#7z e -y imouto.host.7z
mv imouto.host.txt $FILE
fromdos $FILE

echo >> $FILE

# 2、添加一些条目
IP=`grep -m 1 googlesource.com hosts | cut -f 1`
for i in android.googlesource.com gerrit.googlesource.com gerrit-documentation.storage.googleapis.com fonts.gstatic.com;
do
    if ! grep -q $i $FILE; then
        echo -e "${IP}\t${i}" >> $FILE
    fi
done

IP=`grep -m 1 www.googleusercontent.com hosts | cut -f 1`
for i in doc-08-0o-docs.googleusercontent.com doc-0o-0o-docs.googleusercontent.com www-trixcopysheet-opensocial.googleusercontent.com;
do
echo -e "${IP}\t${i}" >> $FILE
done

hn=`hostname`
echo -e "127.0.0.1\t$hn" >> $FILE

sudo cp $FILE /etc/hosts
