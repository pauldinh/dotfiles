#!/bin/bash

# install rustup.rs
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# set Rust compiler
rustup override set stable
rustup update stable
