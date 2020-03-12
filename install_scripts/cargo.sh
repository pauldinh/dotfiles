#!/bin/bash

# assumptions:
# - cargo installed in ${USER}/.local/bin

CARGO_INSTALL_DIR=${USER}/.local/bin

cwd=$(pwd)

cd ${CARGO_INSTALL_DIR}

# bandwith manager
# needs root privileges
sudo ./cargo install bandwhich --root /usr/local

# broot - navigate directories sexily
cargo install broot

# https://github.com/BurntSushi - savant
cargo install ripgrep

# https://github.com/sharkdp
cargo install fd-find hyperfine hexyl diskus

# https://github.com/Peltoche/lsd
cargo install lsd

# bat dependencies
sudo apt install clang llvm-config
cargo install bat

# network bandwidth monitor
sudo cargo install bandwhich --root /usr/local
sudo setcap cap_sys_ptrace,cap_dac_read_search,cap_net_raw,cap_net_admin+ep $(which bandwhich)

# mdbook documentation
cargo install mdbook

cd ${cwd}
