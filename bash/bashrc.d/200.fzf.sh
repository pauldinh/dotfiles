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

fi
