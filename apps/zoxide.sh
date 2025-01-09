#!/bin/bash

# Check if zoxide is already installed
if dpkg -s zoxide >/dev/null 2>&1; then
    # zoxide is already installed
    return 0
fi
sudo apt install -y zoxide
