if which starship >/dev/null 2>&1; then

    eval "$(starship init bash)"

elif [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then

    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_THEME=Single_line_Ubuntu
    source $HOME/.bash-git-prompt/gitprompt.sh

else

    GIT_PS1_DESCRIBE_STYLE="describe"
    GIT_PS1_SHOWCOLORHINTS="y"
    GIT_PS1_SHOWDIRTYSTATE="y"
    GIT_PS1_SHOWSTASHSTATE="y"
    GIT_PS1_SHOWUNTRACKEDFILES="y"
    GIT_PS1_SHOWUPSTREAM="auto"

    if [ $UID -eq "0" ]; then
        PROMPT_COMMAND='__git_ps1 "\[$bakpur\]\[$bldwht\]\u@\h\[$txtrst\]:\[$bldpur\]\w" "\[$bldwht\]\\$\[$txtrst\] "'
    else
        PROMPT_COMMAND='__git_ps1 "\[$bldblu\]\u@\h\[$txtrst\]:\[$bldpur\]\w" "\[$bldwht\]\\$\[$txtrst\] "'
    fi

fi
