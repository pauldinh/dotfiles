if [ -d /opt/ros/melodic ]; then
    #export ROS_PYTHON_VERSION=3
    source /opt/ros/melodic/setup.bash
fi

if [ -f /usr/share/vcstool-completion/vcs.bash ]; then
    source /usr/share/vcstool-completion/vcs.bash
fi

if [ -f ~/ros/ws/gizmo/install/setup.bash ]; then
    source ~/ros/ws/gizmo/install/setup.bash
fi

if [ -f ~/ros/ws/overlay/devel/setup.bash ]; then
    source ~/ros/ws/overlay/devel/setup.bash
fi

if [ -f ~/ros/ws/overlay/install/setup.bash ]; then
    source ~/ros/ws/overlay/install/setup.bash
fi
