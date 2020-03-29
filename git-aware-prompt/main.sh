export GITAWAREPROMPT=${HOME}/.git-aware-prompt
source "${GITAWAREPROMPT}/colors.sh"
# source "${GITAWAREPROMPT}/prompt.sh"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# custom
source "${GITAWAREPROMPT}/custom/git-completion.bash"
source "${GITAWAREPROMPT}/custom/git-prompt.sh"

bash_prompt()
{
    if [ $UID -eq "0" ]; then
        export PROMPT_COMMAND='__git_ps1 "\[$bakred\]\u@\h\[$txtrst\]:\[$bldpur\]\w" "\[$bldwht\]\\$\[$txtrst\] "'
    else
        export PROMPT_COMMAND='__git_ps1 "\[$bldblu\]\u@\h\[$txtrst\]:\[$bldpur\]\w" "\[$bldwht\]\\$\[$txtrst\] "'
    fi
}

bash_prompt
unset bash_prompt
