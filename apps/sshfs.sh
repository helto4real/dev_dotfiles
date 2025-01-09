#!/bin/bash

# Check if sshfs is already installed
if dpkg -s sshfs >/dev/null 2>&1; then
    # sshfs is already installed
    return 0
fi

# Install sshfs
sudo apt-get install -y sshfs

