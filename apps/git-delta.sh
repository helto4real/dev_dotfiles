#!/bin/bash
# Check if delta is already installed
if dpkg -s git-delta >/dev/null 2>&1; then
    # delta is already installed
    return 0
fi

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb -o $temp_dir/git-delta.deb

# Install the package
sudo dpkg -i $temp_dir/git-delta.deb

# Clean up
rm -rf $temp_dir

