#!/bin/bash

set -e

sudo add-apt-repository ppa:pipelight/stable
sudo apt-get update
sudo apt-get install --install-recommends pipelight-multi
sudo pipelight-plugin --update

#update the checksum of Unity3D Web Player
sudo pipelight-plugin --update

#for Firefox, clear the plugin cache
sudo pipelight-plugin --create-mozilla-plugins

#enabling Unity3D Web Player
sudo pipelight-plugin --enable unity3d
