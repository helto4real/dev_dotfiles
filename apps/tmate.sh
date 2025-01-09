#!/bin/bash

# Check if sshfs is already installed
if dpkg -s tmate >/dev/null 2>&1; then
    # sshfs is already installed
    return 0
fi

# Install sshfs
sudp apt-get install -y tmate

