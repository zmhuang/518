#!/bin/bash
set -e
set -x

cd /tmp

FILE=hosts

# 1、下载 hosts 文件
#curl 'http://bj2.dl.baidupcs.com/file/6133b560d7b2f6620895e04564b2285f?fid=33631425-250528-938598892735827&time=1407465395&sign=FDTAXER-DCb740ccc5511e5e8fedcff06b081203-GRXbZMGrAWyvh4cl%2BXSGGuz59f0%3D&to=abp2&fm=Nin,B,U,nc&newver=1&newfm=1&flow_ver=3&expires=1407465995&rt=sh&r=332838405&mlogid=3231459272&sh=1&vuk=-&vbdid=481974168&fn=imouto.host.7z' > hosts.7z
7z e -y imouto.host.7z
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
