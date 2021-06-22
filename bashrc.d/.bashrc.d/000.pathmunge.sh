# Use in other scripts to prepend/append to $PATH
# $ pathmunge <path>       : PATH=<path>:$PATH
# $ pathmunge <path> after : PATH=$PATH:<path>
# e.g. pathmunge $HOME/.local/bin
pathmunge () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

ldlibrarypathmunge () {
    if ! echo "$LD_LIBRARY_PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$1"
        else
            LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH"
        fi
    fi
}
