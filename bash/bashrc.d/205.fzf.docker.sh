if [ -f ~/.fzf.bash ]; then
    if which docker >/dev/null 2>&1; then

        bare() {
          local name
          local container
          name=$1
          if [ -n "$name" ]; then
              name="--name $name"
          else
              unset name
          fi
          container=$(docker images | fzf-down --header-lines 1 --reverse | awk '{image=$1":"$2;print image}')

                #--env="QT_X11_NO_MITSHM=1" \
          [ -n "$container" ] && \
              docker run -ti \
                --gpus all \
                --env="DISPLAY=$DISPLAY" \
                --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
                --volume="/home/pdinh/.ssh:/root/.ssh:ro" \
                --privileged --net=host \
                $name \
                $container
        }

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
                --volume="/home/pdinh/.config/nvim:/root/.config/nvim:ro" \
                --volume="/home/pdinh/dotfiles:/home/pdinh/dotfiles:ro" \
                --volume="/home/pdinh/dotfiles/bash/bashrc.d:/root/.host.bashrc.d:ro" \
                --volume="$HOME/.fzf-multi-snippets:/root/.fzf-multi-snippets:ro" \
                --volume="$HOME/.fzf-shell-snippets:/root/.fzf-shell-snippets:ro" \
                --volume="$HOME/.fzf-single-snippets:/root/.fzf-single-snippets:ro" \
                --volume="$HOME/.notes:/root/.notes:ro" \
                --volume="$HOME/nextcloud:/home/pdinh/nextcloud:ro" \
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

    fi
fi
