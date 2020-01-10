#!/bin/bash

# assumptions:
# - cargo installed in ${USER}/.local/bin

CARGO_INSTALL_DIR=${USER}/.local/bin

cwd=$(pwd)

cd ${CARGO_INSTALL_DIR}

# bandwith manager
# needs root privileges
sudo ./cargo install bandwhich --root /usr/local

# exa - ls alternative
cargo install exa

cd ${cwd}
