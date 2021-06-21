#if [ -f ~/.fzf.bash ]; then

#    # cd to directory
#    _fzd() {
#        local prompt="fzd | cd to directory> "
#        local header="scroll: ctrl+[j/k]"
#        local preview="lsd --tree --depth 1 --group-dirs first --color=always {}"
#        #local preview-window="lsd --tree --depth 1 --group-dirs first --color=always {}"
#        local dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf \
#            --height 40% \
#            --reverse \
#            --prompt "$prompt" \
#            --header "$header" \
#            --preview "$preview" \
#        )
#        echo $dir
#    }
#    # cd to parent directory
#    _fzd_parent() {
#        local dirs=()
#        get_parent_dirs() {
#            if [[ -d "$1" ]]; then dirs+=("$1"); else return; fi
#            if [[ "$1" == '/' ]]; then
#                for _dir in "${dirs[@]}"; do echo $_dir; done
#            else
#                get_parent_dirs $(dirname "$1")
#            fi
#        }
#        local prompt="fzd .. | cd to parent directory> "
#        local header="scroll: ctrl+[jk]"
#        local preview="lsd --tree --depth 1 --group-dirs first --color=always {}"
#        local dir=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf \
#            --height 40% \
#            --reverse \
#            --prompt "$prompt" \
#            --header "$header" \
#            --preview "$preview" \
#        )
#        echo $dir
#    }
#    # cd to directory, or parent directory with '..'  :: fzd
#    fzd() {
#        local dir
#        if [[ $1 == ".." ]]; then
#            dir=$(_fzd_parent $1)
#        else
#            dir=$(_fzd $1)
#        fi
#        if [ ! -z $dir ]; then
#          pushd . >/dev/null 2>&1 && cd $dir
#        fi
#    }

#    # cd to file directory  :: fzdf
#    _fzdf() {
#        local prompt="fzdf | cd to file directory> "
#        local header="scroll: ctrl+[jk]"
#        local preview="bat --color=always --style=header,grid --line-range :200 {}"
#        local file=$(fzf \
#            --height 40% \
#            --reverse \
#            --prompt "$prompt" \
#            --header "$header" \
#            --preview "$preview" \
#         )
#        local dir=$(dirname "$file")
#        echo $dir
#    }
#    fzdf() {
#        local dir=$(_fzdf)
#        if [ ! -z $dir ] && [ $dir != '.' ]; then
#            pushd . >/dev/null 2>&1 && cd $dir
#        fi
#    }

#    # open a file in $EDITOR  :: fzo
#    _fzo() {
#        local prompt="fzo | edit a file> "
#        local header="scroll: ctrl+[jk]"
#        local preview="bat --color=always --style=header,grid --line-range :200 {}"
#        IFS=$'\n' out=("$(fzf \
#            --height 40% \
#            --reverse \
#            --prompt "$prompt" \
#            --header "$header" \
#            --preview "$preview" \
#            --bind 'ctrl-e:execute[echo lol {}]+abort' \
#        )")
#        local key=$(head -1 <<< "$out")
#        local file=$(head -2 <<< "$out" | tail -1)
#        if [ -n "$file" ]; then
#            echo $file
#        fi
#    }
#    fzo() {
#        local file=$(_fzo)
#        if [ ! -z $file ]; then
#            ${EDITOR:-vim} $file
#        fi
#    }

#    # grep in files and open in $EDITOR  :: fzg
#    _fzg() {
#        local prompt="fzg | grep and open> "
#        local header="scroll: ctrl+[jk]"
#        local preview="rg --hidden --no-line-number --pretty --context 10 '"$@"' {} | bat --color=always"
#        local file="$(rg --hidden --no-line-number --max-count=1 --files-with-matches --no-messages "$@" | fzf \
#            --height 40% \
#            --reverse \
#            --prompt "$prompt" \
#            --header "$header" \
#            --preview "$preview" \
#        )"
#        echo $file
#    }
#    fzg() {
#        if [ ! "$#" -gt 0 ]; then echo "usage: fzg <search term>"; return 1; fi
#        local file=$(_fzg $@)
#        if [ ! -z $file ]; then
#            ${EDITOR:-vim} $file
#        fi
#    }

#    ## fman - search available man files with fzf and awk
#    #fman() {
#    #    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
#    #}


#    ## Alt-E snippets for shell
#    #__fzf_snippets__() (
#    #  local line
#    #  shopt -u nocaseglob nocasematch
#    #  line=$(
#    #    cat $HOME/.fzf-shell-snippets |
#    #    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
#    #    awk -F"#" ' { print $1 }' ) &&
#    #    if [[ $- =~ H ]]; then
#    #      sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
#    #    else
#    #      sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
#    #    fi
#    #)
#    #if [[ $- =~ i ]]; then
#    #    # ALT-E - Paste the selected snippet from the ~/.fzf_snippets file. Ignores everything after #
#    #    bind '"\C-f\C-e": " \C-e\C-u`__fzf_snippets__`\e\C-e\er"'
#    #fi

#    ## fb - buku bookmark manager
#    #fb() {
#    #    # save newline separated string into an array
#    #    mapfile -t website <<< "$(buku -p -f 5 | column -ts$'\t' | fzf --multi)"

#    #    # open each website
#    #    for i in "${website[@]}"; do
#    #        index="$(echo "$i" | awk '{print $1}')"
#    #        buku -p "$index"
#    #        buku -o "$index"
#    #    done
#    #}

#fi
