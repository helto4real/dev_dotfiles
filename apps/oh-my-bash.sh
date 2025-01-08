#!/bin/bash

# bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
# source <(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)

# Create a temporary directory
temp_dir=$(mktemp -d)
# Save current directory
current_dir=$(pwd)

# Download tmux
curl -L https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -o $temp_dir/install.sh


# Change to the temp directory
cd $temp_dir

# Configure, make, and install
./install.sh
# Clean up
rm -rf $temp_dir
cd $current_dir
