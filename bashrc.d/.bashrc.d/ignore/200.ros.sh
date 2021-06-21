#export ROS_MASTER_URI=http://master-b:11311
#export ROS_IP=192.168.10.242
#xhost +local:root > /dev/null 2>&1

#source $HOME/ros/ws/overlay/devel/setup.bash
#source $HOME/ros/ws/gizmo/install/setup.bash
#export ROSCONSOLE_CONFIG_FILE=$HOME/.rosconsole

#alias tailrmp='tail -f -n 100 /tmp/aquanaut_rmpflow.log'

#alias odometry='rostopic echo /aquanaut_controller/state_estimator/root_body_odometry -n1 | yq ".header.frame_id + .child_frame_id + .pose.pose + .twist.twist" | tr -d 'null' | jq .[] | column'
#alias joints='rostopic echo /joint_states -n1 | yq ".name + .position + .velocity + .effort" | head -n -1 | yq .[] -C | column'
#alias jointp='rostopic echo /joint_states -n1 | yq ".name + .position" | head -n -1 | yq .[] -C | column -c 100'
#alias jointv='rostopic echo /joint_states -n1 | yq ".name + .velocity" | head -n -1 | yq .[] -C | column -c 100'
#alias jointe='rostopic echo /joint_states -n1 | yq ".name + .effort"   | head -n -1 | yq .[] -C | column -c 100'

SSH_PATH=/home/pdinh/.ssh
OVERLAY_WS=/home/pdinh/ros/src/overlay
#OVERLAY_WS=/home/pdinh/ros/src
#BASHRC=/home/pdinh/dotfiles/bash/bashrc.d
#FZF_MULTI_SNIPPETS=/home/pdinh/Nextcloud/fzf/fzf-multi-snippets
#FZF_SINGLE_SNIPPETS=/home/pdinh/Nextcloud/fzf/fzf-single-snippets
#FZF_SHELL_SNIPPETS=/home/pdinh/Nextcloud/fzf/fzf-shell-snippets
#NOTATIONAL_FZF_NOTES=/home/pdinh/Nextcloud/notes

# available commands: overlay, create, start, enter
# add these to your .bashrc or however you manage to source files in a new terminal
# then simply run them e.g. $ enter
# (name them however you want)
# overlay : creates a container with $OVERLAY_WS as a read-only volume mount into /overlay_ws/src in the container
# create  : same as overlay without the volume mount
# start   : starts a container
# enter   : enters a container with /bin/bash
# overlay and create both take an optional argument to name the container you create, useful to persist the container somewhat
# e.g.
# $ overlay gizmo
# will create a container with your workspace volume mounted and the name gizmo instead of the randomly generated name
overlay() {
  local name
  local container
  name=$1
  if [ -n "$name" ]; then
      name="--name $name"
  else
      unset name
  fi
  container=$(docker images | fzf-down --header-lines 1 --reverse | awk '{image=$1":"$2;print image}')
  #[ -n "$container" ] && \
  #    docker run -ti \
  #      --gpus all \
  #      --env="DISPLAY=$DISPLAY" \
  #      --env="QT_X11_NO_MITSHM=1" \
  #      --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  #      --volume="$SSH_PATH:/root/.ssh:ro" \
  #      --volume="$OVERLAY_WS:/root/overlay_ws/src:ro" \
  #      --volume="$HOME/.config/nvim:/root/.config/nvim:ro" \
  #      --volume="$HOME/dotfiles:/home/pdinh/dotfiles:ro" \
  #      --volume="$HOME/dotfiles/bash/bashrc.d:/root/.bashrc.d:ro" \
  #      --volume="$HOME/.fzf-multi-snippets:/root/.fzf-multi-snippets:ro" \
  #      --volume="$HOME/.fzf-shell-snippets:/root/.fzf-shell-snippets:ro" \
  #      --volume="$HOME/.fzf-single-snippets:/root/.fzf-single-snippets:ro" \
  #      --volume="$HOME/.gitconfig:/root/.gitconfig:ro" \
  #      --volume="$HOME/.gitignore_global:/root/.gitignore_global:ro" \
  #      --volume="$HOME/.git-user:/root/.git-user:ro" \
  #      --volume="$HOME/.notes:/root/.notes:ro" \
  #      --volume="$HOME/Nextcloud:/home/pdinh/Nextcloud:ro" \
  #      --volume="$HOME/ros/docker_mount_stuff/ros:/root/ros:ro" \
  #      --privileged --net=host \
  #      $name \
  #      $container

  #[ -n "$container" ] && \
  #    docker run -ti \
  #      --gpus all \
  #      --env="DISPLAY=$DISPLAY" \
  #      --env="QT_X11_NO_MITSHM=1" \
  #      --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  #      --volume="$SSH_PATH:/root/.ssh:ro" \
  #      --volume="$OVERLAY_WS:/root/overlay_ws/src:ro" \
  #      --volume="$HOME/.config/nvim:/root/.config/nvim:ro" \
  #      --volume="$HOME/dotfiles:/home/pdinh/dotfiles:ro" \
  #      --volume="$HOME/dotfiles/bash/bashrc.d:/root/.bashrc.d:ro" \
  #      --volume="$HOME/.fzf-multi-snippets:/root/.fzf-multi-snippets:ro" \
  #      --volume="$HOME/.fzf-shell-snippets:/root/.fzf-shell-snippets:ro" \
  #      --volume="$HOME/.fzf-single-snippets:/root/.fzf-single-snippets:ro" \
  #      --volume="$HOME/.notes:/root/.notes:ro" \
  #      --volume="$HOME/Nextcloud:/home/pdinh/Nextcloud:ro" \
  #      --volume="$HOME/ros/docker_mount_stuff/ros:/root/ros:ro" \
  #      --privileged --net=host \
  #      $name \
  #      $container

  [ -n "$container" ] && \
      docker run -ti \
        --gpus all \
        --env="DISPLAY=$DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --volume="$SSH_PATH:/root/.ssh:ro" \
        --volume="$OVERLAY_WS:/root/overlay_ws/src:ro" \
        --privileged --net=host \
        $name \
        $container



  #[ -n "$container" ] && \
  #    docker run -ti \
  #      --gpus all \
  #      --env="DISPLAY=$DISPLAY" \
  #      --env="QT_X11_NO_MITSHM=1" \
  #      --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  #      --volume="$SSH_PATH:/root/.ssh:ro" \
  #      --volume="$OVERLAY_WS:/root/overlay_ws/src:ro" \
  #      --privileged --net=host \
  #      $name \
  #      $container
}
