# My Linux development machine setup

This is my personal dev setup and dotfiles for WSL. It is a work in progress and will
be updated as I go along.This setup is designed for a Linux development environment,
using dotfiles and automation to configure various tools and settings.

The installation is driven by a bash script, install.sh, which sets up core
development tools, tmux plugins, system utilities, and programming language support.
It also configures git and manages dotfiles using stow.

The script updates the package list, installs essential tools, configures dotfiles,
and sets up git. After installation, additional steps might be required, such as
mapping network drives and manually installing the .NET debug DAP extension.

The script is tested on WSL2 with Ubuntu 24.04 LTS and may work for other distributions.

## Installation

You will need to create the file `~/.ansible-vault/vault.secret` containing the
password for the ansible vault.

```bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/helto4real/dev_dotfiles/refs/heads/main/install.sh)"

```

## After installation script

1. Map the drives according to the

```bash
/files/network_shares_setup/README.md
```

2. Manually install the dotnet debug DAP extension

## Development Tools

### Core Development Tools

- Git: Used for version control.
- Vim/Neovim: Included as text editors. The alias vi, vim and ni are linked to nvim.
- Tmux: A terminal multiplexer for managing multiple terminal sessions.
- Bash: The primary shell environment.
- Ansible: Used for configuration management.
- Node.js: Included for JavaScript development.

### Programming Languages

- Node.js: Version 22 is installed via nvm.
- Rust: Installed with rustup.
- Go: Go is installed using the official tarball.
- Python: Python 3 is installed, and the pip package manager is used to
install additional packages.
- NET: The .NET SDK is installed using alternative package sources.

### System Utilities and Tools

- fzf: A command-line fuzzy finder, which replaces the version installed by apt.
- bat: A cat clone with syntax highlighting.
- eza: A modern replacement for ls.
- fd: A program to find entries in a file system.
- ripgrep: A line-oriented search tool.
- jq: A lightweight command-line JSON processor.
- lazygit: A simple terminal UI for git.
- gum: A tool for glamorous shell scripts.
- sshfs: Used to mount remote filesystems using SSH.
- tmate: A tool for instant terminal sharing.
- k9s: A Kubernetes terminal UI.
- helm: A package manager for Kubernetes.
- kubectl: A command-line tool for Kubernetes.
- delta: A pager for git diffs.
- oh-my-bash: Framework for managing bash configuration.
- fonts-powerline: Installs fonts used to style the terminal.
- yubikey_support: Installs packages needed to use Yubikey.
- wslu, xdg-utils: Installs packages related to Windows Subsystem for Linux.
- github-cli: Installs Github's commandline interface tool.
- sesh: Installs sesh tool is installed using go.

### Tmux Plugins

- tmux-resurrect: This plugin saves and restores tmux sessions,
including vim and neovim sessions.
- tmux-yank: Enables copying highlighted text to the system clipboard.
- tmux-sessionx: Provides fuzzy searching and management of tmux sessions.
- tmux-sensible: Sets sensible default options for tmux.
- tmux-tokyo-night: A theme for tmux, inspired by the Tokyo Night theme for Vim. It has configurable options for style, separators, and plugins like datetime, weather, and more.
- tmux-pain-control: Provides mappings for moving between tmux panes and vim splits.
- tmux-logging: Used for logging tmux sessions.
- tmux-fzf: Provides various functionalities with fuzzy finding powered by fzf.
