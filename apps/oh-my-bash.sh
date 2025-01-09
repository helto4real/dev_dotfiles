#!/bin/bash

# bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
# source <(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -o $temp_dir/install.sh


# Change to the temp directory
pushd "$temp_dir" 2>&1 > /dev/null

# Make the install script executable
sudo chmod +x install.sh

# Configure, make, and install
./install.sh --unattended


sudo mkdir -p $HOME/.oh-my-bash/themes/axin
# copy the theme to the themes directory
sudo cp $DOTFILES_DIR/config/files/oh-my-bash/themes/axin.theme.sh $HOME/.oh-my-bash/themes/axin/axin.theme.sh

# Clean up
rm -rf $temp_dir

# Cannot do popd because oh-my-bash changes the directory
cd $DOTFILES_DIR
