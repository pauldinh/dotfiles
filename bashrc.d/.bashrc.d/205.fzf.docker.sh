if [ -f ~/.fzf.bash ]; then
    if which docker >/dev/null 2>&1; then

        _fzf-down() {
            fzf --height 50% "$@" --border
        }

        # dcreate - docker run -it <options> <image>
        # - optional arg to create container with name
        # - e.g. dcreate foobar
        dcreate() {
            local name=$1
            if [ -n "$name" ]; then
                name="--name $name"
            else
                unset name
            fi
            local image=$(docker images --filter "dangling=false" | _fzf-down --header-lines 1 --reverse | awk '{image=$1":"$2;print image}')
            if [ -n $image ]; then
                local cmd="docker run -ti \
                    --gpus all \
                    --env="DISPLAY=$DISPLAY" \
                    --env="QT_X11_NO_MITSHM=1" \
                    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
                    --volume="/var/run/docker.sock:/var/run/docker.sock" \
                    --volume="$HOME/.ssh:/root/.ssh:ro" \
                    --volume="$HOME/dev-data:/root/dev-data:ro" \
                    --privileged --net=host \
                    $name \
                    $image"

                sanitized_cmd=$(echo "$cmd" | tr -s " ")
                history -s "$sanitized_cmd"
                eval $sanitized_cmd
            fi
        }

        # denter - docker exec -it <container> /bin/bash
        denter() {
            local prompt="denter | docker exec -it <container> /bin/bash | scroll: ctrl+[jk]> "
            local fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
            local container=$(docker ps --format "$fmtstring" | _fzf-down --prompt "$prompt" --header-lines 1 --reverse -q "$1" | awk '{print $1}')
            [ -n "$container" ] && \
                history -s "docker exec -ti $container /bin/bash" && \
                docker exec -ti $container /bin/bash
        }

        # dstart - docker start <container>
        dstart() {
            local prompt="dstart | docker start <container> | scroll: ctrl+[jk], select/deselect: tab/shift-tab> "
            local fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
            local containers=$(docker ps --filter "status=exited" --format "$fmtstring" | _fzf-down --prompt "$prompt" --header-lines 1 --reverse --multi | awk '{print $1}')
            [ -n "$containers" ] && \
                local sanitized_containers=$(echo $containers | tr -s " ") && \
                history -s "docker start $sanitized_containers" && \
                docker start $sanitized_containers
        }

        # dstop - docker stop <container>
        dstop() {
            local prompt="dstop | docker stop <container> | scroll: ctrl+[jk], select/deselect: tab/shift-tab> "
            local fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
            local containers=$(docker ps --format "$fmtstring" | _fzf-down --prompt "$prompt" --header-lines 1 --reverse -q "$1" --multi | awk '{print $1}')
            [ -n "$containers" ] && \
                local sanitized_containers=$(echo $containers | tr -s " ") && \
                history -s "docker stop $sanitized_containers" && \
                docker stop $sanitized_containers
        }

        # drm - docker rm <container>
        # - non destructive, adds command to history as a comment
        drm() {
            local prompt="drm | docker rm <container> | scroll: ctrl+[jk], select/deselect: tab/shift-tab> "
            local fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
            local containers=$(docker ps --filter "status=exited" --format "$fmtstring" | _fzf-down --prompt "$prompt" --header-lines 1 --reverse -q "$1" --multi | awk '{print $1}' | tr "\n" " ")
            [ -n "$containers" ] && \
                history -s "#docker rm $containers" && \
                printf "adding destructive command to history as a #comment, up arrow and remove # to execute\n" && \
                echo "#docker rm $containers"
        }

        # drmi - docker rmi <image>
        # - non destructive, adds command to history as a comment
        drmi() {
            local prompt="drm | docker rmi <image> | scroll: ctrl+[jk], select/deselect: tab/shift-tab> "
            local fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
            local images=$(docker images --filter "dangling=false" | _fzf-down --prompt "$prompt" --header-lines 1 --reverse -q "$1" --multi | awk '{print $1":"$2}' | tr "\n" " ")
            [ -n "$images" ] && \
                history -s "#docker rmi $images" && \
                printf "adding destructive command to history as a #comment, up arrow and remove # to execute\n" && \
                echo "#docker rmi $images"
        }

        # dpull - docker pull <image>
        dpull() {
            local prompt="dpull | docker pull <image> | scroll: ctrl+[jk]> "
            local fmtstring="table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}"
            local image=$(docker images --filter "dangling=false" | _fzf-down --prompt "$prompt" --header-lines 1 --reverse -q "$1" | awk '{print $1":"$2}' | tr "\n" " ")
            [ -n "$image" ] && \
                printf "docker pull $image\n" && \
                history -s "docker pull $image" && \
                docker pull $image
        }

    fi
fi
