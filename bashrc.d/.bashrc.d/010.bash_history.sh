# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=10000000
HISTSIZE=${HISTFILESIZE}

# append to the history file, don't overwrite it
shopt -s histappend

# PROMPT_COMMAND:
# 1)    history -a: log each command when issued
# 2)    history -n: read all lines not already read and append
# 3) if <stuff> fi: log *every* command to timestamped log in ~/.bash_logs
PROMPT_COMMAND='history -a; history -n; if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.bash_logs/bash-history-$(date "+%Y-%m-%d").log; fi'
