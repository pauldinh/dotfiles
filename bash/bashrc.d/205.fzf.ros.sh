if [ -f ~/.fzf.bash ]; then
    if [ -d /opt/ros ]; then

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

        if [[ $- =~ i ]]; then
          bind '"\er": redraw-current-line'

          bind '"\C-f\C-t": "$(gft)\e\C-e\er"'
          bind '"\C-f\C-v": "$(gfv)\e\C-e\er"'
          bind '"\C-f\C-p": "$(gfp)\e\C-e\er"'
        fi

    fi
fi
