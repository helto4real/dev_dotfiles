#!/bin/bash

# Check if tmux correct version is installed
if [ "$(tmux -V | cut -c 6-)" == "3.5a" ]; then
    # tmux version 3.5a is already installed
    return 0
fi

# Install dependencies
sudo apt-get install -y libevent-dev ncurses-dev bison pkg-config

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz -o $temp_dir/tmux-3.5a.tar.gz

# Extract the tar file
tar -xzf $temp_dir/tmux-3.5a.tar.gz -C $temp_dir

# Change to the tmux directory
cd $temp_dir/tmux-3.5a

# Configure, make, and install
./configure
make
sudo make install

# Clean up
rm -rf $temp_dir
