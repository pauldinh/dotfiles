if [ -f ~/.fzf.bash ]; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    #export FZF_DEFAULT_OPTS="--no-height"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
    #export FZF_TMUX=1

    # Use fd (https://github.com/sharkdp/fd) instead of the default find
    # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    _fzf_compgen_path() {
      echo "in fd compgen path"
      fd --hidden --follow --exclude ".git" . "$1"
    }

    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
      echo "in fd compgen dir"
      fd --type d --hidden --follow --exclude ".git" . "$1"
    }

    # need to source *after* overriding compgen commands
    source ~/.fzf.bash

    is_in_git_repo() {
      git rev-parse HEAD > /dev/null 2>&1
    }

    fzf-down() {
      fzf --height 50% "$@" --border
    }

    # git fzf integration
    # all of these are bound to Ctrl Foo + Ctrl Bar, where Foo and Bar are keystrokes
    # all of these are bound to keystrokes (ignore first g) e.g. ggf is Ctrl G + Ctrl F
    gft() {
        rostopic list |
            fzf \
                --prompt 'rostopic> ' \
                --header '[enter] to paste | ctrl + [e]cho or [p]ub' \
                --bind 'ctrl-e:execute[echo rostopic echo {}]+abort' \
                --bind 'ctrl-p:execute[echo rostopic pub {} ; MSGTYPE=$(rostopic type {}); echo $MSGTYPE; ]+abort' \
                --preview '(rostopic info {})'
    }

    # Ctrl F + Ctrl V - Ser*v*ics
    gfv() {
        rosservice list |
            fzf \
                --prompt 'rosservice> ' \
                --header '[enter] to paste | ctrl + [p] to call' \
                --bind 'ctrl-p:execute[echo rosservice call {}]+abort' \
                --preview '(rosservice info {})'
    }

    # Ctrl F - Ctrl P - *Parameters
    gfp() {
      rosparam list |
          fzf \
              --prompt 'rosparam> ' \
              --header '[enter] to paste | ctrl + [g]et or se[t] | [pgup/pgdn] to scroll preview'\
              --bind 'ctrl-g:execute[echo rosparam get -p {}]+abort' \
              --bind 'ctrl-t:execute[echo rosparam set {}]+abort' \
              --bind 'pgup:preview-page-up' \
              --bind 'pgdn:preview-page-down' \
              --preview '(rosparam get -p {} | bat)'
    }

    # keybinds for git + fzf
    if [[ $- =~ i ]]; then
      bind '"\er": redraw-current-line'

      bind '"\C-f\C-t": "$(gft)\e\C-e\er"'
      bind '"\C-f\C-v": "$(gfv)\e\C-e\er"'
      bind '"\C-f\C-p": "$(gfp)\e\C-e\er"'
    fi

    # dirty files
    ggf() {
      is_in_git_repo || return
      git -c color.status=always status --short |
      fzf-down -m --ansi --nth 2..,.. --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' | cut -c4- | sed 's/.* -> //'
    }

    # branches
    ggb() {
      is_in_git_repo || return
      git branch -a --color=always | grep -v '/HEAD\s' | sort |
      fzf-down --ansi --multi --tac --preview-window right:70% \
        --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
      sed 's/^..//' | cut -d' ' -f1 |
      sed 's#^remotes/##'
    }

    # tags
    ggt() {
      is_in_git_repo || return
      git tag --sort -version:refname |
      fzf-down --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -200'
    }

    # checkout
    ggi() {
      is_in_git_repo || return
      git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
      fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
      grep -o "[a-f0-9]\{7,\}"
    }

    # remotes
    ggr() {
      is_in_git_repo || return
      git remote -v | awk '{print $1 "\t" $2}' | uniq |
      fzf-down --tac \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
      cut -d$'\t' -f1
    }

    # stash stack
    ggs() {
      is_in_git_repo || return
      git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
      cut -d: -f1
    }

    ggp() {
      local pid
      pid=$(ps -ef | fzf-down --header-lines 1 --info inline --layout reverse --multi |awk '{print $2}')

      if [ -n "$pid" ]; then
          echo $pid | xargs kill -9
      fi
    }

    # works in non-git directories - z with scores, ordered in descending order
    ggu() {
      _z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info --tac | sed 's/^[0-9,.]* *//'
    }

    # keybinds for git + fzf
    if [[ $- =~ i ]]; then
      bind '"\er": redraw-current-line'
      bind '"\C-g\C-f": "$(ggf)\e\C-e\er"'
      bind '"\C-g\C-b": "$(ggb)\e\C-e\er"'
      bind '"\C-g\C-t": "$(ggt)\e\C-e\er"'
      bind '"\C-g\C-i": "$(ggi)\e\C-e\er"'
      bind '"\C-g\C-r": "$(ggr)\e\C-e\er"'
      bind '"\C-g\C-s": "$(ggs)\e\C-e\er"'

      # Extra
      bind '"\C-g\C-p": "$(ggp)\e\C-e\er"'
      bind '"\C-g\C-u": "$(ggu)\e\C-e\er"'

      bind '"\C-f\C-t": "$(gft)\e\C-e\er"'
      bind '"\C-f\C-v": "$(gfv)\e\C-e\er"'
      bind '"\C-f\C-p": "$(gfp)\e\C-e\er"'
    fi


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

    __fzf_snippets__() (
      local line
      shopt -u nocaseglob nocasematch
      line=$(
        cat $HOME/.fzf-snippets |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
        awk -F"#" ' { print $1 }' ) &&
        if [[ $- =~ H ]]; then
          sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
        else
          sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
        fi
    )

    create() {
      local name
      local container
      name=$1
      if [ -n "$name" ]; then
          name="--name $name"
      else
          unset name
      fi
      container=$(docker images | fzf-down --header-lines 1 --reverse | awk '{image=$1":"$2;print image}')

      [ -n "$container" ] && \
          docker run -ti \
            --gpus all \
            --env="DISPLAY=$DISPLAY" \
            --env="QT_X11_NO_MITSHM=1" \
            --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
            --volume="/home/pdinh/.ssh:/root/.ssh:ro" \
            --privileged --net=host \
            $name \
            $container
    }

    start() {
      local fmstring
      local container
      fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
      container=$(docker ps --filter "status=exited" --format "$fmtstring" | fzf-down --header-lines 1 --reverse | awk '{print $1}')
      [ -n "$container" ] && docker start $container
    }

    enter() {
      local fmtstring
      local container
      fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
      container=$(docker ps --format "$fmtstring" | fzf-down --header-lines 1 --reverse -q "$1" | awk '{print $1}')
      [ -n "$container" ] && docker exec -ti "$container" /bin/bash
    }

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

    # keybinds for git + fzf
    if [[ $- =~ i ]]; then
      bind '"\er": redraw-current-line'

      bind '"\C-f\C-t": "$(gft)\e\C-e\er"'
      bind '"\C-f\C-v": "$(gfv)\e\C-e\er"'
      bind '"\C-f\C-p": "$(gfp)\e\C-e\er"'

      # ALT-E - Paste the selected snippet from the ~/.fzf_snippets file. Ignores everything after #
      #bind '"\ee": " \C-e\C-u`__fzf_snippets__`\e\C-e\e^\er"'
      bind '"\ee": " \C-e\C-u`__fzf_snippets__`\e\C-e\er"'

    fi
fi
