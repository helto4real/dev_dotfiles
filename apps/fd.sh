#!/bin/bash

# Check if fd is already installed
if dpkg -s fd-find >/dev/null 2>&1; then
    # fd is already installed
    return 0
fi

sudo apt-get install -y fd-find

# get config dir from bat --config-dir
FD_FILE=$(which fdfind)

sudo mkdir -p $HOME/.local/bin
# Create symlink to fd to $HOME/.local/bin
sudo ln -s $FD_FILE $HOME/.local/bin/fd

