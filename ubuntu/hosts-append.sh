#!/bin/bash
/bin/cp /etc/hosts /tmp/ -v
cat hosts-append >> /tmp/hosts
sudo cp /tmp/hosts /etc/hosts
