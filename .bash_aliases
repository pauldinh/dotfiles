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

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

# From: https://pintsize.jsc.nasa.gov/drc-software/drc_common/blobs/develop/scripts/util-git.sh
export GITAWAREPROMPT=~/.bash/git-aware-prompt
if [ -d $GITAWAREPROMPT ]
then
    # From: https://github.com/jimeh/git-aware-prompt (mentioned by Dane in Confluence)
    # This solution doesn't screw up bash's ability to count characters so you don't get weird line wrapping when editing old lines
    source $GITAWAREPROMPT/main.sh
    export PS1="\[$bldgrn\]\u@\h\[$bldblu\]:\w\[$bldylw\]\$git_branch\[$bldred\]\$git_dirty\[$txtrst\]\$ "
fi

# TODO: actual aliases start here, clean the above up (and below)

alias psg='ps aux | grep'
alias k9='kill -9'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias gb="git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short)' refs/remotes"
alias pport="sudo netstat -lpn | grep"
alias gp='git remote update -p; git merge --ff-only @{u}'
alias gitlol='git log --graph --pretty=oneline --abbrev-commit'
alias clog='tail -f /var/log/syslog'
alias gbclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias gr='git remote -v'

# tmux
export PATH=$HOME/.tmuxifier/bin:$PATH
eval "$(tmuxifier init -)"
export TMUXIFIER_LAYOUT_PATH=$HOME/.tmux-layouts
export EDITOR=vim
alias tml='tmuxifier load-session'
alias tmk='tmux kill-session -t'
alias tmks='tmux kill-server'
alias tmls='tmux ls'
alias tmd='tmux detach'
alias tma='tmux attach -t'

# ros
alias sros='source /opt/ros/kinetic/setup.bash'

# anaconda python
alias sap='export PATH=~/anaconda3/bin:$PATH'

# catkin laziness
function ce() {
    catkin config --install --extend $1
}

function cb() {
    catkin build $1
}

function cbe() {
    catkin build --env-cache $1
}

function cbd() {
    catkin build --profile debug $1
}

function cbde() {
    catkin build --profile debug --cache-env $1
}

function cbr() {
    catkin build --profile release $1
}

function cbre() {
    catkin build --profile release --cache-env $1
}

function ct() {
    catkin run_tests --no-deps $1 && catkin test --no-deps $1
}

function ccov() {
    catkin build --no-deps $1 -DCMAKE_BUILD_TYPE=Coverage --make-args run_coverage_$1
}

function cfor() {
    catkin build --no-deps $1 --make-args format_code_$1
}

function ccd() {
    catkin profile add --copy-active debug
    catkin profile set debug
    catkin config --log-space logs_debug
    catkin config -b build_debug
    catkin config -d devel_debug
    catkin config -i install_debug
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Debug
}

function ccr() {
    catkin profile add --copy-active release
    catkin profile set release
    catkin config --log-space logs_release
    catkin config -b build_release
    catkin config -d devel_release
    catkin config -i install_release
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
}

function ccrrr() {
    catkin profile add --copy-active release
    catkin profile set release
    catkin config --log-space logs_release
    catkin config -b build_release
    catkin config -d devel_release
    catkin config -i install_release
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
}


alias ckc='catkin config'

# vpn
alias vpn='sudo openvpn --config ~/vpn/client.ovpn'

# git-branch-clean
function gbc() {
    red=$'\e[1;31m'
    grn=$'\e[1;32m'
    yel=$'\e[1;33m'
    blu=$'\e[1;34m'
    mag=$'\e[1;35m'
    cyn=$'\e[1;36m'
    end=$'\e[0m'

    for i in * ; do
      if [ -d "$i" ]; then
          reponame=$(basename "$i")
          printf "+----------------------------------------------------+\n"
          printf "| ${cyn}%-50s${end} |\n" $reponame
          printf "+----------------------------------------------------+\n"
          cd $reponame
          git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
          cd ..
          printf "\n"
      fi
    done
}

function lookatthat() {
   ls -al | lolcat -F 0.3
}

