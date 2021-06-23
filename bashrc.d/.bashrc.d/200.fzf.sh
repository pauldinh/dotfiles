if [ -f ~/.fzf.bash ]; then

    if which tree >/dev/null 2>&1; then
        _fzf_shell_ls_preview="tree -L 1 -C {}"
    else
        _fzf_shell_ls_preview="ls --color --group-directories-first -F {}"
    fi

    if which bat >/dev/null 2>&1; then
        _fzf_shell_cat_preview="bat --color=always --style=header,grid --line-range :200 {}"
        _fzf_shell_grep_cat="bat --color=always"
    else
        _fzf_shell_cat_preview="cat {}"
        _fzf_shell_grep_cat="cat"
    fi

    # cd to directory
    _fzd() {
        local prompt="fzd | cd to directory> "
        local header="scroll: ctrl+[j/k]"
        local dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf \
            --height 40% \
            --layout=reverse \
            --prompt "$prompt" \
            --header "$header" \
            --preview "$_fzf_shell_ls_preview" \
        )
        echo $dir
    }
    # cd to parent directory
    _fzd_parent() {
        local dirs=()
        get_parent_dirs() {
            if [[ -d "$1" ]]; then dirs+=("$1"); else return; fi
            if [[ "$1" == '/' ]]; then
                for _dir in "${dirs[@]}"; do echo $_dir; done
            else
                get_parent_dirs $(dirname "$1")
            fi
        }
        local prompt="fzd .. | cd to parent directory> "
        local header="scroll: ctrl+[jk]"
        local dir=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf \
            --height 40% \
            --layout=reverse \
            --prompt "$prompt" \
            --header "$header" \
            --preview "$_fzf_shell_ls_preview" \
        )
        echo $dir
    }
    # cd to directory, or parent directory with '..'  :: fzd
    fzd() {
        local dir
        if [[ $1 == ".." ]]; then
            dir=$(_fzd_parent $1)
        else
            dir=$(_fzd $1)
        fi
        if [ ! -z $dir ]; then
            local cmd="cd $dir && ls"
            history -s "$cmd"
            pushd . >/dev/null 2>&1 && printf "$cmd\n" && eval $cmd
        fi
    }

    # cd to file directory  :: fzdf
    _fzdf() {
        local prompt="fzdf | cd to file directory> "
        local header="scroll: ctrl+[jk]"
        local file=$(fzf \
            --height 40% \
            --layout=reverse \
            --prompt "$prompt" \
            --header "$header" \
            --preview "$_fzf_shell_cat_preview" \
         )
        local dir=$(dirname "$file")
        echo $dir
    }
    fzdf() {
        local dir=$(_fzdf)
        if [ ! -z $dir ] && [ $dir != '.' ]; then
            local cmd="cd $dir && ls"
            history -s "$cmd"
            pushd . >/dev/null 2>&1 && printf "$cmd\n" && eval $cmd
        fi
    }

    # open a file in $EDITOR  :: fzo
    _fzo() {
        local prompt="fzo | edit a file> "
        local header="scroll: ctrl+[jk]"
        IFS=$'\n' out=("$(fzf \
            --height 40% \
            --layout=reverse \
            --prompt "$prompt" \
            --header "$header" \
            --preview "$_fzf_shell_cat_preview" \
            --bind 'ctrl-e:execute[echo lol {}]+abort' \
        )")
        local key=$(head -1 <<< "$out")
        local file=$(head -2 <<< "$out" | tail -1)
        if [ -n "$file" ]; then
            echo $file
        fi
    }
    fzo() {
        local file=$(_fzo)
        if [ ! -z $file ]; then
            local cmd="${EDITOR:-vim} $file"
            history -s "$cmd"
            eval $cmd
        fi
    }

    # grep in files and open in $EDITOR  :: fzg
    # TODO: can't get this working without ripgrep, screw it
    if which rg >/dev/null 2>&1; then
        _fzg() {
            local initial_query="$@"
            local prompt="fzg | grep and open> "
            local header="scroll: ctrl+[jk]"
            local preview="rg --hidden --no-line-number --pretty --context 10 '"$@"' {} | bat --color=always"
            local file="$(rg --hidden --no-line-number --max-count=1 --files-with-matches --no-messages "$@" | fzf \
                --layout=reverse \
                --prompt "$prompt" \
                --header "$header" \
                --preview "$preview" \
            )"
            echo $file
        }
        fzg() {
            if [ ! "$#" -gt 0 ]; then echo "usage: fzg <search term>"; return 1; fi
            local file=$(_fzg $@)
            if [ ! -z $file ]; then
                local cmd="${EDITOR:-vim} $file"
                history -s "$cmd"
                eval $cmd
            fi
        }
    else
        fzg() {
            echo "sorry, only supports ripgrep: https://github.com/BurntSushi/ripgrep"
        }
    fi

    # Use fd (https://github.com/sharkdp/fd) instead of the default find
    # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    if which fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

        _fzf_compgen_path() {
            fd --hidden --follow --exclude ".git" . "$1"
        }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
            fd --type d --hidden --follow --exclude ".git" . "$1"
        }

        # need to source *after* overriding compgen commands
        source ~/.fzf.bash
    fi

fi
