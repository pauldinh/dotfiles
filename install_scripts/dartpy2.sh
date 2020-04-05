#!/bin/bash

sudo apt-get install build-essential cmake pkg-config git
sudo apt-get install libeigen3-dev libassimp-dev libccd-dev libfcl-dev libboost-regex-dev libboost-system-dev
sudo apt-get install libtinyxml2-dev liburdfdom-dev
sudo apt-get install libxi-dev libxmu-dev freeglut3-dev libopenscenegraph-dev
sudo apt-get install libbullet-dev libode-dev liboctomap-dev
sudo apt-get install libnlopt-dev

cwd=$(pwd)

# pybind for Ubuntu 18.10 or lower
cd /tmp
git clone https://github.com/pybind/pybind11 -b 'v2.2.4' --single-branch --depth 1
cd pybind11
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DPYBIND11_TEST=OFF
make -j8
sudo make install

# compile dartpy from source (pip install for python2 only works in 19.04+)
cd /tmp
git clone git://github.com/dartsim/dart.git
cd dart
git checkout tags/v6.9.0
mkdir build
cd build
cmake .. -DDART_BUILD_DARTPY=ON -DCMAKE_INSTALL_PREFIX=/usr/ -DCMAKE_BUILD_TYPE=Release -DDARTPY_PYTHON_VERSION=2.7
make dartpy
sudo make install

cd $cwd
