#!/bin/bash
set -e

FILE=/tmp/hosts

/bin/cp /etc/hosts /tmp/ -v
cat hosts-append >> $FILE

hn=`hostname`
echo "127.0.0.1\t$hn" >> $FILE

sudo cp $FILE /etc/hosts
