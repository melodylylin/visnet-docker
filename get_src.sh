#!/bin/bash
if [ ! -d ./work/px4 ] ; then
    cd ./work
    git clone git@github.com:PX4/PX4-Autopilot px4
    cd ..
    cp config/AbuDhabi.sdf ./work/px4/Tools/simulation/gz/worlds/default.sdf
    mkdir ./work/px4/Tools/simulation/gz/worlds/media
    cp config/media/* ./work/px4/Tools/simulation/gz/worlds/media
fi

if [ ! -d ./work/ros2_ws/src ] ; then
    mkdir -p ./work/ros2_ws/src
    cd work/ros2_ws/src
    git clone git@github.com:PX4/px4_msgs.git
    git clone -b humble git@github.com:gazebosim/ros_gz.git
    git clone git@github.com:zp-yang/visnet.git
fi

export HOST_UID=$(id -u)
export HOST_GID=$(id -g)
xhost +local:docker
