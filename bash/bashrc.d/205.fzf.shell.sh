if [ -f ~/.fzf.bash ]; then

    # fzfcd - cd to selected directory
    _fzfcd() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf --prompt 'fzfcd | cd to directory> ' --header 'ctrl + [j/k] to scroll' --preview 'lsd --group-dirs first --color=always {}')
      echo $dir
    }

    fzfcd() {
      local dir=$(_fzfcd)
      if [ ! -z $dir ]; then
        cd $dir
      fi
    }

    # fzfcdp - cd to parent directory
    _fzfcdp() {
      local declare dirs=()
      get_parent_dirs() {
        if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
        if [[ "${1}" == '/' ]]; then
          for _dir in "${dirs[@]}"; do echo $_dir; done
        else
          get_parent_dirs $(dirname "$1")
        fi
      }
      local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --prompt 'fzfcdp | cd to parent directory> ' --header 'ctrl + [j/k] to scroll' --preview 'lsd --group-dirs first --color=always {}')
      echo $DIR
    }

    fzfcdp() {
      local dir=$(_fzfcdp)
      if [ ! -z $dir ]; then
        cd $dir
      fi
    }

    # fzfcdf - cd into the directory of the selected file
    _fzfcdf() {
       local file
       local dir
       file=$(fzf --prompt 'fzfcdf | cd to directory of file> ' --header 'ctrl + [j/k] to scroll' --preview 'bat --color=always {}')
       dir=$(dirname "$file")
       echo $dir
   }

    fzfcdf() {
      cd $(_fzfcdf)
    }

    # fif - search file contents
    _fif() {
        local file
        file="$(rg --no-line-number --max-count=1 --files-with-matches --no-messages "$@" | fzf --prompt 'fif | find in file> ' --header 'ctrl + [j/k] to scroll' --preview="rg --no-line-number --pretty --context 10 '"$@"' {} | bat --color=always")"
        echo $file
    }
    fif() {
      if [ ! "$#" -gt 0 ]; then echo "usage: fif <search term>"; return 1; fi
      local file=$(_fif $@)
      if [ ! -z $file ]; then
        ${EDITOR:-vim}  $file
      fi
    }

    # fzfed - open a file
    _fzfed() {
      IFS=$'\n' out=("$(fzf --prompt 'fzfed | edit a file> ' --header 'ctrl + [j/k] to scroll' --preview 'bat --color=always {}')")
      key=$(head -1 <<< "$out")
      file=$(head -2 <<< "$out" | tail -1)
      if [ -n "$file" ]; then
        echo $file
      fi
    }
    fzfed() {
      local file=$(_fzfed)
      if [ ! -z $file ]; then
        ${EDITOR:-vim}  $file
      fi
    }

    # fman - search available man files with fzf and awk
    fman() {
        man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
    }


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
