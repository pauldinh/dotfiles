# From: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# From: https://pintsize.jsc.nasa.gov/drc-software/drc_common/blobs/develop/scripts/util-git.sh
export GITAWAREPROMPT=~/.bash/git-aware-prompt
if [ -d $GITAWAREPROMPT ]
then
    # From: https://github.com/jimeh/git-aware-prompt (mentioned by Dane in Confluence)
    # This solution doesn't screw up bash's ability to count characters so you don't get weird line wrapping when editing old lines
    source $GITAWAREPROMPT/main.sh
    export PS1="\[$bldgrn\]\u@\h\[$bldblu\]:\w\[$bldylw\]\$git_branch\[$bldred\]\$git_dirty\[$txtrst\]\$ "
fi

alias psg='ps aux | grep'
alias k9='kill -9'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias gb="git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short)' refs/remotes"
alias ggg="GIT_AUTHOR_NAME='Paul Dinh' GIT_AUTHOR_EMAIL='paul.dinh@gmail.com' git gui"
alias pport="sudo netstat -lpn | grep"
alias gp='git remote update -p; git merge --ff-only @{u}'
alias gitlol='git log --graph --pretty=oneline --abbrev-commit'
alias vupdate='sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/valkyrie.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"'

# tmux
export PATH=$HOME/.tmuxifier/bin:$PATH
eval "$(tmuxifier init -)"
export TMUXIFIER_LAYOUT_PATH=$HOME/.tmux-layouts
export EDITOR=vim
alias tml='tmuxifier load-session'
alias tmks='tmux kill-server'
alias tmls='tmux ls'
alias tmd='tmux detach'
alias tma='tmux attach -t'
