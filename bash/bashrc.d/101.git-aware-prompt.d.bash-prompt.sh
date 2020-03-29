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
