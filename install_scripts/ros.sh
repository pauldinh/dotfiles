#!/bin/bash

## sources and keys
#sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
#sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
#sudo apt update

## ROS Melodic
#sudo apt install ros-melodic-desktop-full

## rosdep
#sudo rosdep init
#rosdep update

## catkin tools and other shit
#sudo apt install \
#    python-rosinstall \
#    python-rosinstall-generator \
#    python-wstool \
#    build-essential \
#    python-catkin-tools \
#    python3-vcstool

echo 'export ROS_PYTHON_VERSION=2' >> ${HOME}/.bashrc
