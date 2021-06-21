if which tmux >/dev/null 2>&1; then
    alias tmk="tmux kill-session -t"
    alias tmks="tmux kill-server"
    alias tmls="tmux ls"
    alias tmd="tmux detach"
    alias tma="tmux attach -t"
fi
