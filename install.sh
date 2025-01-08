#!/bin/bash

# This script uses a combination of ansible and stow to
# install and configure dotfiles on a new system.


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


DOTFILES_LOG="$HOME/.dotfiles.log"

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

#### MAIN ####

# Make sure we have sudo access for the rest of the script
# activate sudo and return error if not successful
# sudo -v || printf "${LRED} failed to t ${NC}\n" && exit 1
sudo -v || printf "${LRED}Failed to sudo, exiting script...\n" && exit 1

set -e

## Install the required packages for this script

### 1. Install Ansible
# check lsb_release -si
if ! dpkg -s ansible >/dev/null 2>&1; then
    _task "Installing Ansible"
        _cmd "sudo apt-get update"
        _cmd "sudo apt-get install -y software-properties-common"
        _cmd "sudo apt-add-repository -y ppa:ansible/ansible"
        _cmd "sudo apt-add-repository -y universe"
        _cmd "sudo apt-get update"
        _cmd "sudo apt-get install -y ansible"
        _cmd "sudo apt-get install python3-argcomplete"
        _cmd "sudo activate-global-python-argcomplete3"
        _cmd "sudo apt-get install libssl-dev"
fi

### 2. Install Python3 and Pip if not installed

if ! dpkg -s python3 >/dev/null 2>&1; then
    _task "Installing Python3"
        _cmd "sudo apt-get install -y python3"
fi
if ! dpkg -s python3-pip >/dev/null 2>&1; then
    _task "Installing Python3 Pip"
        _cmd "sudo apt-get install -y python3-pip"
fi

### 3. Install jq and toilet
if ! dpkg -s jq >/dev/null 2>&1; then
    _task "Installing jq"
        _cmd "sudo apt-get install -y jq"
fi

if ! dpkg -s toilet >/dev/null 2>&1; then
    _task "Installing toilet"
        _cmd "sudo apt-get install -y toilet"
fi

### 4. Install stow
if ! dpkg -s stow >/dev/null 2>&1; then
    _task "Installing Stow"
        _cmd "sudo apt-get install -y stow"
fi
# # Check if pip module watchdog is installed
# if ! pip3 list | grep watchdog >/dev/null 2>&1; then
#     _task "Installing Python3 Watchdog"
#         _cmd "pip3 install watchdog"
# fi
