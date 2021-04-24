if which pet >/dev/null 2>&1; then

    function pet-prev() {
       PREV=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
       sh -c "pet new `printf %q "$PREV"`"
     }

    function pet-select() {
      BUFFER=$(pet search --query "$READLINE_LINE")
      READLINE_LINE=$BUFFER
      READLINE_POINT=${#BUFFER}
    }

    if [[ $- =~ i ]]; then
        bind -x '"\C-x\C-r": "pet-select"'
    fi

    alias pe='pet exec'

fi
