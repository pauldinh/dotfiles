if [ -z "$ROS_PACKAGE_PATH" ]; then
    if [ -d /opt/ros/noetic ]; then
        export ROS_PYTHON_VERSION=3
        source /opt/ros/noetic/setup.bash
    elif [ -d /opt/ros/melodic ]; then
        source /opt/ros/melodic/setup.bash
    fi
fi

if [ -f /usr/share/vcstool-completion/vcs.bash ]; then
    source /usr/share/vcstool-completion/vcs.bash
fi
