# avoid duplicates
HISTCONTROL=ignoredups:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=10000000
HISTSIZE=${HISTFILESIZE}

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# when shell exits, append to the history file, don't overwrite it
shopt -s histappend

# PROMPT_COMMAND:
# 1)    history -a: log each command when issued
# 2) if <stuff> fi: log *every* command to timestamped log in ~/.bash_logs
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'history -a; if [ "$(id -u)" -ne 0 ]; then echo "$(pwd) $(history 1)" >> $HOME/.bash_logs/bash-history-$(date "+%Y-%m-%d").log; fi'
