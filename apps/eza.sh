#!/bin/bash

# Check if eza is already installed
if dpkg -s eza >/dev/null 2>&1; then
    # eza is already installed
    return 0
fi

# # check if /etc/apt/sources.list.d/eza.list exists
if [ ! -f "/etc/apt/sources.list.d/eza.list" ]; then
    # add gpg key https://raw.githubusercontent.com/eza-community/eza/main/deb.asc
    curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /usr/share/keyrings/eza-archive-keyring.gpg

    # add eza repository deb [signed-by=/usr/share/keyrings/eza.gpg] http://deb.gierens.de stable main
    echo "deb [signed-by=/usr/share/keyrings/eza-archive-keyring.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/eza.list

    sudo apt-get update
fi

sudo apt-get install -y eza
