if which bat >/dev/null 2>&1; then
    alias cat="bat -p"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
