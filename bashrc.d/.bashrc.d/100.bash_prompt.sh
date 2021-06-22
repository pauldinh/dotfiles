if [ -f ~/.gitstatus/gitstatus.prompt.sh ]; then
    source ~/.gitstatus/gitstatus.prompt.sh
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\] '           # green user@host
    PS1+='\[\033[01;34m\]\w\[\033[00m\]'              # blue current working directory
    PS1+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} '   # git status (requires promptvars option)
    PS1+='\[\033[01;$((31+!$?))m\]\$\[\033[00m\] '    # green/red (success/error) $/# (normal/root)
    PS1+='\[\e]0;\u@\h: \w\a\]'                       # terminal title: user@host: dir
fi
