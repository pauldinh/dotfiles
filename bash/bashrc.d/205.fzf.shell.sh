if [ -f ~/.fzf.bash ]; then

    # fd - cd to selected directory
    fdd() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune \
                      -o -type d -print 2> /dev/null | fzf +m) &&
      cd "$dir"
    }

    # fdr - cd to parent directory
    fdr() {
      local declare dirs=()
      get_parent_dirs() {
        if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
        if [[ "${1}" == '/' ]]; then
          for _dir in "${dirs[@]}"; do echo $_dir; done
        else
          get_parent_dirs $(dirname "$1")
        fi
      }
      local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
      cd "$DIR"
    }

    # cdf - cd into the directory of the selected file
    cdf() {
       local file
       local dir
       file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
    }

    # fman - search available man files with fzf and awk
    fman() {
        man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
    }

    # fif - search file contents
    fif() {
        if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
        local file
        file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
    }

    # fo - open a file
    #   - CTRL-O to open with `open` command,
    #   - CTRL-E or Enter key to open with the $EDITOR
    fo() (
      IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
      key=$(head -1 <<< "$out")
      file=$(head -2 <<< "$out" | tail -1)
      if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
      fi
    )

    # Alt-E snippets for shell
    __fzf_snippets__() (
      local line
      shopt -u nocaseglob nocasematch
      line=$(
        cat $HOME/.fzf-shell-snippets |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
        awk -F"#" ' { print $1 }' ) &&
        if [[ $- =~ H ]]; then
          sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
        else
          sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
        fi
    )
    if [[ $- =~ i ]]; then
        # ALT-E - Paste the selected snippet from the ~/.fzf_snippets file. Ignores everything after #
        bind '"\C-f\C-e": " \C-e\C-u`__fzf_snippets__`\e\C-e\er"'
    fi

    # fb - buku bookmark manager
    fb() {
        # save newline separated string into an array
        mapfile -t website <<< "$(buku -p -f 5 | column -ts$'\t' | fzf --multi)"

        # open each website
        for i in "${website[@]}"; do
            index="$(echo "$i" | awk '{print $1}')"
            buku -p "$index"
            buku -o "$index"
        done
    }

fi
