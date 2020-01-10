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

cd ${cwd}
