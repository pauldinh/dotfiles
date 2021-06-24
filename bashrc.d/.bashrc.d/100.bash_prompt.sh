if [ -f ~/.gitstatus/gitstatus.prompt.sh ]; then
    source ~/.gitstatus/gitstatus.prompt.sh

    _isroot=false
    [[ "${UID}" -eq 0 ]] && _isroot=true

    if ${_isroot}; then
        _prompt_color_userhost="01;31"   # bold/light; red
        _prompt_color_cwd="01;31"        # bold/light; red
    else
        _prompt_color_userhost="01;32"   # bold/light; green
        _prompt_color_cwd="01;34"        # bold/light; blue
    fi

    PS1='\[\033[${_prompt_color_userhost}m\]\u@\h\[\033[00m\] ' # green user@host
    PS1+='\[\033[${_prompt_color_cwd}m\]\w\[\033[00m\]'         # blue current working directory
    PS1+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} '             # git status (requires promptvars option)
    PS1+='\[\033[01;$((31+!$?))m\]\$\[\033[00m\] '              # green/red (success/error) $/# (normal/root)
    PS1+='\[\e]0;\u@\h: \w\a\]'                                 # terminal title: user@host: dir
fi
