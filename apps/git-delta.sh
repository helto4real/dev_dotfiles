#!/bin/bash

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb -o $temp_dir/git-delta.deb

# Install the package
sudo dpkg -i $temp_dir/git-delta.deb

# Clean up
rm -rf $temp_dir

