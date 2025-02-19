#!/bin/bash
# This script uses a combination of ansible and stow to
# install and configure dotfiles on a new system.

GIT_DIRERCTORY="$HOME/git"
IS_FIRST_RUN="$HOME/.dotfiles_run"
VAULT_SECRET="$HOME/.ansible-vault/vault.secret"
DOT_CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$GIT_DIRERCTORY/dotfiles"
DOTFILES_LOG="$HOME/.dotfiles.log"

git_user_name="Tomas Hellström"
git_user_email='$ANSIBLE_VAULT;1.1;AES256
39376566383334663865353964653637666462643833353438323862353965366262326637333165
6265656638643139303430343736383932363232393639310a653239383637363535326163626132
34626232343261383931356630306164326136613564383432656262623861656334666664373061
3539653833653566350a626136663934333539303164396435393935366631643339333538313665
31373332313064356136663465333838623466636563316337303833323730353464'

git_user_signingkey='$ANSIBLE_VAULT;1.1;AES256
66336634393762616562366531663636326463656531316265613839366466653166626330396538
6166393937383462363935633433333839613765383863310a376464376531353436613139353134
38383831633437643738663762303861373432646365343539303934613836343637626136633537
3632316137303632390a336337313833623430653735313037323833373965663238653132326533
37396637646562616565363961313661643265363666396534356266323664646239'

# color codes
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

#emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"


# _header colorize the given argument with spacing
function _task {
    # if _task is called while a task was set, complete the previous
    if [[ $TASK != "" ]]; then
        printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
    fi
    # set new task title and print
    TASK=$1
    printf "${LBLACK} [ ]  ${TASK} \n${LRED}"
}

# _cmd performs commands with error checking
function _cmd {
    #create log if it doesn't exist
    if ! [[ -f $DOTFILES_LOG ]]; then
        touch $DOTFILES_LOG
    fi
    # empty conduro.log
    > $DOTFILES_LOG
    # hide stdout, on error we print and exit
    if eval "$1" 1> /dev/null 2> $DOTFILES_LOG; then
        return 0 # success
    fi
    # read error from log and add spacing
    printf "${OVERWRITE}${LRED} [X]  ${TASK}${LRED}\n"
    while read line; do
        printf "      ${line}\n"
    done < $DOTFILES_LOG
    printf "\n"
    # remove log file
    rm $DOTFILES_LOG
    # exit installation
    exit 1
}

function _clear_task {
    TASK=""
}

function _task_done {
    printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
    _clear_task
}

# Function to decrypt a value using ansible-vault
decrypt_value() {
    local encrypted_value=$1
    echo -e "$encrypted_value" | ansible-vault decrypt  --vault-password-file "$VAULT_SECRET"
}

#### MAIN ####

# Make sure we have sudo access for the rest of the script
# activate sudo and return error if not successful
# sudo -v || printf "${LRED} failed to t ${NC}\n" && exit 1
if ! sudo -v  >/dev/null 2>&1; then
    printf "${LRED}Failed to sudo, exiting script...\n"
    exit 1
fi

set -e

## Install the required packages for this script
### 1. Update the package list
_task "Updating package list and install essential packages"
    _cmd "sudo apt-get update"
    _cmd "sudo apt-get install -y git build-essential cifs-utils"
_task_done

### 2. Install Ansible
# check lsb_release -si
if ! dpkg -s ansible >/dev/null 2>&1; then
    _task "Installing Ansible"
        _cmd "sudo apt-get install -y software-properties-common"
        _cmd "sudo apt-add-repository -y ppa:ansible/ansible"
        _cmd "sudo apt-add-repository -y universe"
        _cmd "sudo apt-get update"
        _cmd "sudo apt-get install -y ansible"
        _cmd "sudo apt-get install -y python3-argcomplete python3-pynvim"
        _cmd "sudo activate-global-python-argcomplete"
        _cmd "sudo apt-get install -y libssl-dev"
    _task_done
fi

### 3. Install Python3 and Pip if not installed
if ! dpkg -s python3 >/dev/null 2>&1; then
    _task "Installing Python3"
        _cmd "sudo apt-get install -y python3"
    _task_done
fi
if ! dpkg -s python3-pip >/dev/null 2>&1; then
    _task "Installing Python3 Pip"
        _cmd "sudo apt-get install -y python3-pip"
    _task_done
fi
# Check if pyenv is installed by checking if the environment variable $PYENV_ROOT is set
if [ -z "$PYENV_ROOT" ]; then
    _task "Installing Pyenv"
        _cmd "curl https://pyenv.run | bash"
    _task_done
fi

### 4. Install jq and toilet
if ! dpkg -s jq >/dev/null 2>&1; then
    _task "Installing jq"
        _cmd "sudo apt-get install -y jq"
    _task_done
fi

if ! dpkg -s toilet >/dev/null 2>&1; then
    _task "Installing toilet"
        _cmd "sudo apt-get install -y toilet"
    _task_done
fi

### 5. Install stow
if ! dpkg -s stow >/dev/null 2>&1; then
    _task "Installing Stow"
        _cmd "sudo apt-get install -y stow"
    _task_done
fi
# # Check if pip module watchdog is installed
# if ! pip3 list | grep watchdog >/dev/null 2>&1; then
#     _task "Installing Python3 Watchdog"
#         _cmd "pip3 install watchdog"
# fi

if [ ! -d "$GIT_DIRERCTORY" ]; then
    mkdir -p "$GIT_DIRERCTORY"
fi

# Decrypt the encrypted secret
DECRYPTED_GIT_USER_EMAIL=$(decrypt_value "$git_user_email")
DECRYPTED_GIT_USER_SIGNINGKEY=$(decrypt_value "$git_user_signingkey")
### Setup git before cloning the repository
_task "Setting up git"
    _cmd "git config --global user.name \"Tomas Hellström\""
    _cmd "git config --global user.email \"$DECRYPTED_GIT_USER_EMAIL\""
    _cmd "git config --global user.signingkey \"$DECRYPTED_GIT_USER_SIGNINGKEY\""
    _cmd "git config --global diff.colorMoved default"
    _cmd "git config --global fetch.prune true"
    _cmd "git config --global init.defaultBranch main"
    _cmd "git config --global pull.rebase true"
    _cmd "git config --global alias.cmp \"!f() { git add -A && git commit -m \"$@\" && git push; }; f\""
    _cmd "git config --global gpg.program \"/mnt/c/Program Files (x86)/GnuPG/bin/gpg.exe\""
    _cmd "git config --global commit.gpgSign true"
    _cmd "git config --global core.pager delta"
    _cmd "git config --global delta.navigate true"
    _cmd "git config --global delta.side-by-side true"
    _cmd "git config --global merge.conflictstyl \"diff3\""
    _cmd "git config --global interactive.diffFilter \"delta --color-only\""
_task_done

# Clone repository
if ! [[ -d "$DOTFILES_DIR" ]]; then
    _task "Cloning repository"
        _cmd "git clone --quiet https://github.com/helto4real/dev_dotfiles.git $DOTFILES_DIR"
    _task_done
else
    _task "Updating repository"
        _cmd "git -C $DOTFILES_DIR pull --quiet"
    _task_done
fi

pushd "$DOTFILES_DIR" 2>&1 > /dev/null

if [ ! -d "$DOT_CONFIG_DIR" ]; then
    mkdir -p "$DOT_CONFIG_DIR"
fi

# delete .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    _task "Removing .bashrc"
        _cmd "rm $HOME/.bashrc"
    _task_done
fi

### 6. Stow all the dotfiles
_task "Stowing .config dotfiles"
    _cmd "cd ./config/dotconfig && stow . && cd ../.."
_task_done
_task "Stowing home directory dotfiles"
    _cmd "cd ./config/home && stow . && cd ../.."
_task_done

# list all the tasks named as file in the ./apps directory and loop through them and source the file using a task
for file in ./apps/*; do
    _task "Installing $(basename "${file%.*}")"
        _cmd ". $file"
    _task_done
done

_task "Setting up git remote to ssh one"
    _cmd "git remote set-url origin git@github.com:helto4real/dev_dotfiles.git"
_task_done

popd 2>&1 > /dev/null

if ! [[ -f "$IS_FIRST_RUN" ]]; then
    echo -e "${CHECK_MARK} ${GREEN}First run complete!${NC}"
    echo -e "${ARROW} ${CYAN}Please reboot your computer to complete the setup.${NC}"
    touch "$IS_FIRST_RUN"
fi

