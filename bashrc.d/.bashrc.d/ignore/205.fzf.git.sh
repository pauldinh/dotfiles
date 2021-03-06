if [ -f ~/.fzf.bash ]; then
    if which git >/dev/null 2>&1; then

        # git fzf integration
        # all of these are bound to Ctrl Foo + Ctrl Bar, where Foo and Bar are keystrokes
        # all of these are bound to keystrokes (ignore first g) e.g. ggf is Ctrl G + Ctrl F

        is_in_git_repo() {
            git rev-parse HEAD > /dev/null 2>&1
        }

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

        # pkill
        ggp() {
          local pid
          pid=$(ps -ef | fzf-down --header-lines 1 --info inline --layout reverse --multi |awk '{print $2}')

          if [ -n "$pid" ]; then
              echo $pid | xargs sudo kill -9
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
        fi

    fi
fi
