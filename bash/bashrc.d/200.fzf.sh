if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
    export FZF_DEFAULT_OPTS="--ansi"
    export FZF_CTRL_T_COMMAND="fd --type file --follow --hidden --exclude .git --color=always"
fi
