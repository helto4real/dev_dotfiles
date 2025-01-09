#!/bin/bash
# Check if oh-my-bash is already installed
if [ -d "$HOME/.oh-my-bash" ]; then
    # oh-my-bash is already installed
    return 0
fi
# Manual installation through cloning the repo
# since we do not want the installer to change the shell
git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash

# # Create a temporary directory
# temp_dir=$(mktemp -d)
#
# # Download repo from github
# curl -L https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -o $temp_dir/install.sh
#
#
# # Change to the temp directory
# pushd "$temp_dir" 2>&1 > /dev/null
#
# # Make the install script executable
# sudo chmod +x install.sh
#
# # Configure, make, and install
# ./install.sh --unattended
#

mkdir -p $HOME/.oh-my-bash/themes/axin
# copy the theme to the themes directory
cp $DOTFILES_DIR/config/files/oh-my-bash/themes/axin.theme.sh $HOME/.oh-my-bash/themes/axin/axin.theme.sh

# # Clean up
# rm -rf $temp_dir
#
# # Cannot do popd because oh-my-bash changes the directory
# cd $DOTFILES_DIR
