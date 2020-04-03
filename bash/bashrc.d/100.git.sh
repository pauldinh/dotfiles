# show remote branches, sorted by recent activity
alias gb="git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short)' refs/remotes"

# prune remote branches and pull
alias gp='git remote update -p; git merge --ff-only @{u}'

# condensed git log, phasing this out in favor of `tig`
alias gitlol='git log --graph --pretty=oneline --abbrev-commit --all --decorate --color'
alias gg='git log --graph --pretty=oneline --abbrev-commit --all --decorate --color'

# show all remote branches that have been merged into the current
alias gbr='git branch -r --merged'

# delete all local branches that have been merged into the current branch (ignores branches named master/dev*)
# intended use is to switch to master or develop and run, but i guess it could be used on feature branches
alias gbclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'

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
                if [[ $output ]]; then
                    printf "${cyn}$(pwd)${1#.}/%s${end}\n" $reponame
                    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
                    printf "\n"
                fi
            fi
            cd ..
        fi
    done
}

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

function gitfile() {
    git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | sed -n 's/^blob //p' \
    | sort --numeric-sort --key=2 \
    | cut -c 1-12,41- \
    | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest \
    | awk '$2 >= 2^20'
}
