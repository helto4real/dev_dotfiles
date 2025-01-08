#!/bin/bash

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb -o $temp_dir/bat.deb

# Install the package
sudo dpkg -i $temp_dir/bat.deb

# get config dir from bat --config-dir
BAT_CONFIG_DIR=$(bat --config-dir)
curl -L https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme -o $BAT_CONFIG_DIR/themes/
# Clean up
rm -rf $temp_dir

