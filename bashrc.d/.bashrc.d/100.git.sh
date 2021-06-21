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
