if which exa >/dev/null 2>&1; then
    alias ls='exa --group-directories-first'
    alias ll='ls -l --git --all'
    alias lsr='ls -l --git --all --sort newest'

    function lst() {
        local depth=2
        if [ ! -z "$1" ]; then
            depth=$1
        fi
        exa --tree --level=$depth --git --long --all --group-directories-first
    }
fi
