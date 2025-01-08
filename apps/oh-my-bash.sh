#!/bin/bash

# bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
# source <(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -o $temp_dir/install.sh


# Change to the temp directory
pushd "$temp_dir" 2>&1 > /dev/null

# Configure, make, and install
./install.sh
# Clean up
rm -rf $temp_dir

popd
