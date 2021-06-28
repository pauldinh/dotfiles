if [ -d $HOME/.tmuxifier ]; then
    pathmunge $HOME/.tmuxifier/bin
    eval "$(tmuxifier init -)"
    alias tml="tmuxifier load-session"
fi

if [ -d $HOME/.tmux-layouts ]; then
    export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"
fi
