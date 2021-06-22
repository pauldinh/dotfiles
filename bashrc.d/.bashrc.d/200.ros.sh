if [ -f /usr/local/share/vsctool-completion/vcs.bash ]; then
    source /usr/share/vcstool-completion/vcs.bash
fi

if which catkin >/dev/null 2>&1; then
    source `catkin locate --shell-verbs`
fi
