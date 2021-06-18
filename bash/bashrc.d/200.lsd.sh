if which lsd >/dev/null 2>&1; then
    alias ls='lsd --group-dirs first'
    alias lls='lsd -l --group-dirs first -rS'
    alias llt='lsd -l --group-dirs first -rt'
    alias ll='lsd --group-dirs first -lAF'
fi
