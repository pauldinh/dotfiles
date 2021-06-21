if which tldr >/dev/null 2>&1; then
    # autocomplete
    complete -W "$(tldr 2>/dev/null --list)" tldr
fi
