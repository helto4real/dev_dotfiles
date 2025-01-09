#!/bin/bash

# Check if nodejs version 22 is already installed
if [ "$(node --version | cut -d 'v' -f 2)" == "22" ]; then
    # nodejs version 22 is already installed
    return 0
fi

# install nvm script
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Download and install Node.js:
nvm install 22

