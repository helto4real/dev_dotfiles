#!/bin/bash

# Check if lazydocker is already installed
if [ -x "$(command -v lazydocker)" ]; then
    # lazydocker is already installed
    return 0
fi

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

