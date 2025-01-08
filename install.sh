#!/bin/bash
. tasks
# This script uses a combination of ansible and stow to
# install and configure dotfiles on a new system.



#### MAIN ####

# Make sure we have sudo access for the rest of the script
# activate sudo and return error if not successful
# sudo -v || printf "${LRED} failed to t ${NC}\n" && exit 1
if ! sudo -v  >/dev/null 2>&1; then
    printf "${LRED}Failed to sudo, exiting script...\n"
    exit 1
fi

echo "hello"
set -e

## Install the required packages for this script
### 1. Update the package list
_task "Updating package list and install essential packages"
    _cmd "sudo apt-get update"
    _cmd "sudo apt-get install git build-essential"
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
        _cmd "sudo apt-get install python3-argcomplete"
        _cmd "sudo activate-global-python-argcomplete3"
        _cmd "sudo apt-get install libssl-dev"
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
