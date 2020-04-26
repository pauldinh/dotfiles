if [ -f ~/.fzf.bash ]; then

    # location of snippets, folder created in step 2 or custom location
    snippetrc=~/.fzf-single-snippets
    multisnippetrc=~/.fzf-multi-snippets

    # edit single line snippet
    cfg-snippetrc() { $EDITOR $snippetrc ;}

    # edit multiline snippet
    cfg-multisnippetrc() { $EDITOR $multisnippetrc/"$(ls $multisnippetrc/ | fzf -e -i)" ;}

    #create new multiline snippet
    multisnippet() { $EDITOR $multisnippetrc/"$1" ;}

    # single/multi-line snippets that copy to clipboard
    fzf-snippet() {
        selected="$(cat $snippetrc | sed '/^$/d' | sort -n | fzf -e -i )"
        # remove tags, leading and trailing spaces, also no newline
        [ -n "$selected" ] && echo "$selected" | sed -e s/\;\;\.\*\$// | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d '\n' | xclip -selection clipboard &>/dev/null
    }

    fzf-multisnippet() {
        filename=$($FZF_CTRL_T_COMMAND . $multisnippetrc | fzf --ansi --preview '(highlight -O ansi -l {} 2> /dev/null || cat {})')
        [ -n "$filename" ] && cat $filename | xclip -selection clipboard &>/dev/null
    }

    if [[ $- =~ i ]]; then
        bind '"\er": redraw-current-line'

        bind '"\C-f\C-n": "$(fzf-snippet)\e\C-e\er"'
        bind '"\C-f\C-m": "$(fzf-multisnippet)\e\C-e\er"'
    fi

fi
