if [ ! -z "$PS1" ]; then
    if which navi >/dev/null 2>&1; then
        eval "$(navi widget bash)"
    fi
fi
