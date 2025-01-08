#!/bin/bash

# Check if fd is already installed
if dpkg -s fd-find >/dev/null 2>&1; then
    # fd is already installed
    return 0
fi

sudo apt-get install -y fd-find

# get config dir from bat --config-dir
FD_FILE=$(which fdfind)


# Create symlink to fd to $HOME/.local/bin
ln -s $FD_FILE $HOME/.local/bin/fd

