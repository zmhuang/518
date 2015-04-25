#!/bin/bash
set -e
#set -x

FILE=hosts

cd /tmp

fromdos $FILE
echo >> $FILE

# 2、添加一些条目
IP=`grep -m 1 googlesource.com hosts | sed 's/\([0-9.]\+\).*/\1/'`
for i in android.googlesource.com gerrit.googlesource.com gerrit-documentation.storage.googleapis.com fonts.gstatic.com;
do
    if ! grep -q $i $FILE; then
        echo -e "${IP}\t${i}" >> $FILE
    fi
done

IP=`grep -m 1 www.googleusercontent.com hosts | sed 's/\([0-9.]\+\).*/\1/'`
for i in doc-08-0o-docs.googleusercontent.com doc-0o-0o-docs.googleusercontent.com www-trixcopysheet-opensocial.googleusercontent.com doc-04-0o-docs.googleusercontent.com doc-0s-0o-docs.googleusercontent.com doc-10-0o-docs.googleusercontent.com doc-14-0o-docs.googleusercontent.com; 
do
echo -e "${IP}\t${i}" >> $FILE
done

IP=`grep -m 1 0.docs.google.com hosts | sed 's/\([0-9.]\+\).*/\1/'`
for i in {10..100};
do
echo -e "${IP}\t${i}.docs.google.com" >> $FILE
((++i))
done

echo -e "68.232.35.117   static.mentor-cdn.com" >> $FILE
echo -e "72.15.153.164   www.codepool.biz" >> $FILE

hn=`hostname`
echo -e "127.0.0.1\t$hn" >> $FILE

# dl 应当使用 nslookup 结果，以提升下载速度
for i in dl.google.com dl.l.google.com dl-ssl.google.com;
do
sed -i '/$i/ d' $FILE
done

sudo cp $FILE /etc/hosts
