#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

source $DIR/.general_aliases
source $DIR/.catkin_aliases
source $DIR/.cli_aliases
source $DIR/.git_aliases
source $DIR/.hmi_aliases
source $DIR/.tmux_aliases

source $DIR/.dumb_aliases
