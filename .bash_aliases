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
alias gitlol='git log --graph --pretty=oneline --abbrev-commit --all --decorate --color'
alias gg='git log --graph --pretty=oneline --abbrev-commit --all --decorate --color'
alias clog='tail -f /var/log/syslog'
alias gbclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias gr='git remote -v'
alias gbr='git branch -r --merged'
alias gs='git status'

function gitfile() {
    git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | sed -n 's/^blob //p' \
    | sort --numeric-sort --key=2 \
    | cut -c 1-12,41- \
    | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest \
    | awk '$2 >= 2^20'
}

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

# anaconda python
alias sap2='export PATH=~/anaconda2/bin:$PATH'
alias sap3='export PATH=~/anaconda3/bin:$PATH'

# catkin laziness
function ce() {
    catkin config --install --extend $1
}

function cb() {
    catkin build $1 -j 10
}

function cbt() {
    catkin build --no-deps --this
}

function cbo() {
    catkin build --no-deps $1
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

function crt() {
    catkin run_tests --no-deps $1
}

function ct() {
    catkin test --no-deps $1
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
    catkin config --log-space logs
    catkin config -b build
    catkin config -d devel
    catkin config -i install
    #catkin config --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
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

function ccrunner() {
    catkin profile add --copy-active runner
    catkin profile set runner
    catkin config --log-space logs_runner
    catkin config -b build_runner
    catkin config -d devel_runner
    catkin config -i install_runner
    #catkin config --cmake-args -DCMAKE_BUILD_TYPE=ReleaseWithDebInfo
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
}


function rcd() {
    jump dd/src/$1
}

alias ckc='catkin config'

# vpn
alias vpn='sudo openvpn --config ~/vpn/client.ovpn'

# git-branch-clean
function gbc() {
    cyn=$'\e[1;36m'
    end=$'\e[0m'

    printf "Pruning local, non- master/develop branches that have been merged into the current branch..\n"

    for i in * ; do
        if [ -d "$i" ]; then
            reponame=$(basename "$i")
            cd $reponame
            if [ -d .git ]; then
                output=$(git branch --merged | egrep -v "(^\*|master|dev)")
                if [ $output ]; then
                    printf "${cyn}$(pwd)${1#.}/%s${end}\n" $reponame
                    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
                    printf "\n"
                fi
            fi
            cd ..
        fi
    done
}

function lookatthat() {
   ls -al | lolcat -F 0.3
}

# enable/disable touchpad
alias etp='xinput --enable "SynPS/2 Synaptics TouchPad"'
alias dtp='xinput --disable "SynPS/2 Synaptics TouchPad"'

# rebind caps to ctrl
setxkbmap -layout us -option ctrl:nocaps

function git-size {
    # set the internal field spereator to line break, so that we can iterate easily over the verify-pack output
    IFS=$'\n';

    # list all objects including their size, sort by size, take top 10
    objects=`git verify-pack -v $1/.git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head`

    echo "All sizes are in kB's. The pack column is the size of the object, compressed, inside the pack file."

    output="size,pack,SHA,location"
    allObjects=`git rev-list --all --objects`
    for y in $objects
    do
        # extract the size in bytes
        size=$((`echo $y | cut -f 5 -d ' '`/1024))
        # extract the compressed size in bytes
        compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
        # extract the SHA
        sha=`echo $y | cut -f 1 -d ' '`
        # find the objects location in the repository tree
        other=`echo "${allObjects}" | grep $sha`
        #lineBreak=`echo -e "\n"`
        output="${output}\n${size},${compressedSize},${other}"
    done

    echo -e $output | column -t -s ', '
}

alias cat='bat'
alias ls='lsd --group-dirs first'
alias lls='lsd -l --group-dirs first -S'
alias llt='lsd -l --group-dirs first -t'
alias tree='ls --tree'
alias vco='vcs custom --args checkout'
alias vca='vcs custom --args'
alias vcarpo='vcs custom --args remote prune origin'

# gpr - create merge request from command line
# Colour constants for nicer output.
GREEN='\033[0;32m'
RESET='\033[0m'

# Push the current branch to origin, set upstream, open the PR page if possible.
gpr() {
    # Get the current branch name, or use 'HEAD' if we cannot get it.
    branch=$(git symbolic-ref -q HEAD)
    branch=${branch##refs/heads/}
    branch=${branch:-HEAD}

    # Pushing take a little while, so let the user know we're working.
    echo "Opening pull request for ${GREEN}${branch}${RESET}..."

    # Push to origin, grabbing the output but then echoing it back.
    push_output=`git push origin -u ${branch} 2>&1`
    echo ""
    echo "push_output"
    echo ${push_output}

    regex="(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?"
    # If there's anything which starts with http, it's a good guess it'll be a
    # link to GitHub/GitLab/Whatever. So open it.
    link=$(echo ${push_output} | grep -o 'https.*' | sed -e 's/[[:space:]]*$//')
    echo ""
    echo "link"
    echo ${link}
    if [ ${link} ]; then
        echo ""
        echo "Opening: ${GREEN}${link}${RESET}..."
        python -mwebbrowser ${link}
    fi
}

alias vp='vcs pull && vcarpo && gbc'
alias saq='source /home/pdinh/ws/aquanaut/install_release/setup.bash'
alias pong='ping'

# YES I AM LAZY
alias sbrc='source ~/.bashrc'

# gcalcli
alias hmical='gcalcli --calendar="HMI Company Calendar"'
alias hmicala='gcalcli --calendar="HMI Company Calendar" agenda'
alias hmicalw='gcalcli --calendar="HMI Company Calendar" calw'
alias hmicalm='gcalcli --calendar="HMI Company Calendar" calm'
alias mecal='gcalcli --calendar="pdinh@houstonmechatronics.com"'
alias mecala='gcalcli --calendar="pdinh@houstonmechatronics.com" agenda'
alias mecalw='gcalcli --calendar="pdinh@houstonmechatronics.com" calw'
alias mecalm='gcalcli --calendar="pdinh@houstonmechatronics.com" calm'
alias aqcal='gcalcli --calendar="Aquanaut Team Calendar"'
alias aqcala='gcalcli --calendar="Aquanaut Team Calendar" agenda'
alias aqcalw='gcalcli --calendar="Aquanaut Team Calendar" calw'
alias aqcalm='gcalcli --calendar="Aquanaut Team Calendar" calm'

# rclone sync
alias testrcnotes='rclone sync ~/notes gdrive:notes --dry-run'
alias rcnotes='rclone sync ~/notes gdrive:notes'

# set LS_COLORS explicitly for alacritty (likely a problem with `lsd`, not alacritty)
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
