#!/bin/bash

NVIM_VERSION='0.10.3'

# Check if nvim version 0.10.3 is already installed
if [ "$(nvim --version | head -n 1 | cut -d ' ' -f 2)" == v"$NVIM_VERSION" ]; then
    # nvim version 0.10.3 is already installed
    return 0
fi
sudo apt-get install -y \
    cmake \
    curl \
    pkg-config \
    libtool \
    unzip \
    ansible-lint \
    ripgrep \
    libfuse2

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download neovim appimage and copy to /usr/local/bin
curl -L https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage -o $temp_dir/nvim.appimage
sudo cp -f $temp_dir/nvim.appimage /usr/local/bin/nvim

# Make the appimage executable
sudo chmod +x /usr/local/bin/nvim

# Clean up
rm -rf $temp_dir
