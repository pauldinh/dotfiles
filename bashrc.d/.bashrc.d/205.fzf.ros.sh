if [ -f ~/.fzf.bash ]; then
    if [ -d /opt/ros ]; then

        # tldr
        # keybinds will pipe `ros(topic|service|param) list` into fzf
        # pressing enter in fzf prompt will paste current selection into terminal
        # example:
        # - type `rostopic info ` in terminal
        # - ctrl-f,ctrl-t to show topic prompt
        # - fuzzy search desired topic
        # - hit enter
        # - terminal will now have `rostopic info <your topic>`

        # topic/service/param fzf prompts have additional keybindings


        # (t)opics
        # ctrl-f + ctrl-t
        # additional keybinds at fzf prompt (instead of hitting enter)
        # ctrl-e (*e*cho)
        # - pipe `rostopic echo <selection>` into terminal
        # - does not execute command to allow additional args e.g. "-n1" to echo a single message
        # ctrl-u (p*u*blish)
        # - pipe `rostopic pub <selection_topic> <topic_msg_type> ` into terminal
        # - hit <tab> <tab> to autocomplete empty message
        gft() {
            rostopic list |
                fzf \
                    --prompt 'rostopic> ' \
                    --header '[enter] to paste | ctrl + [e]cho or p[u]b' \
                    --bind 'ctrl-e:execute[echo rostopic echo {}]+abort' \
                    --bind 'ctrl-u:execute[echo rostopic pub {} ; MSGTYPE=$(rostopic type {}); echo $MSGTYPE; ]+abort'
        }

        # ser(v)ices
        # ctrl-f + ctrl-v
        # additional keybinds at fzf prompt (instead of hitting enter)
        # ctrl-c (*c*all)
        # - pipe `rosservice call <selection>` into terminal
        # - hit <tab> <tab> to autocomplete empty message
        gfv() {
            rosservice list |
                fzf \
                    --prompt 'rosservice> ' \
                    --header '[enter] to paste | ctrl + [c]all' \
                    --bind 'ctrl-c:execute[echo rosservice call {}]+abort'
        }

        # para(m)eters
        # ctrl-f + ctrl-m
        # additional keybinds at fzf prompt (instead of hitting enter)
        # ctrl-g (*g*et)
        # - pipe `rosparam get -p <selection>` into terminal
        # - `-p` arg is for pretty-print, useful when getting urdf
        # ctrl-t (se*t)
        # - pipe `rosparam set <selection>` into terminal
        # - up to you to fill out the rest of the command
        gfp() {
          rosparam list |
              fzf \
                  --prompt 'rosparam> ' \
                  --header '[enter] to paste | ctrl + [g]et or se[t] | [pgup/pgdn] to scroll preview' \
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
          bind '"\C-f\C-m": "$(gfp)\e\C-e\er"'
        fi

    fi
fi
