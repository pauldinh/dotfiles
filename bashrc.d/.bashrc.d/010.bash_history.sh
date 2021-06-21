# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL="erasedups:ignoreboth"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=100000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
#PROMPT_COMMAND='history -a'

# Don't record some commands
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT="%F %T "

# log *every* command to ~/.history in a timestamped log

# PROMPT_COMMAND:
# 1)    history -a: log each command when issued
# 2) if <stuff> fi: log *every* command to timestamped log in ~/.bash_logs
PROMPT_COMMAND='history -a;if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.bash_logs/bash-history-$(date "+%Y-%m-%d").log; fi'
