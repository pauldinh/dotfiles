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
