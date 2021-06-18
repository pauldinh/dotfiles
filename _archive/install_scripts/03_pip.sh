#!/bin/bash

cwd=$(pwd)

cd /tmp
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# install pip2 since it's the ROS Melodic default
sudo python2 get-pip.py

cd ${cwd}
