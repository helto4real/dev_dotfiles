# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"
export BROWSER=wslview
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="axin"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  docker
  git
  gh
  go
  helm
  kubectl
  ssh
  system
  terraform
  kubectl
  tmux
  vault
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  chmod
  general
  ls
  misc
  terraform
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  ansible
  bashmarks
  git
  goenv
  golang
  kubectl
  progress
  xterm
  zoxide
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

### Following lines is to make gpg use card reader (Yubikey)
### https://github.com/BlackReloaded/wsl2-ssh-pageant#bashzsh
WIN_USER="tomas"
SSH_DIR="${HOME}/.ssh" #
mkdir -p "${SSH_DIR}"
wsl2_ssh_pageant_bin="${SSH_DIR}/wsl2-ssh-pageant.exe"
ln -sf "/mnt/c/Users/${WIN_USER}/.ssh/wsl2-ssh-pageant.exe" "${wsl2_ssh_pageant_bin}"

listen_socket() {
  sock_path="$1" && shift
  fork_args="${sock_path},fork"
  exec_args="${wsl2_ssh_pageant_bin} $@"

  if ! ps x | grep -v grep | grep -q "${fork_args}"; then
    rm -f "${sock_path}"
    (setsid nohup socat "UNIX-LISTEN:${fork_args}" "EXEC:${exec_args}" &>/dev/null &)
  fi
}

# SSH
export SSH_AUTH_SOCK="${SSH_DIR}/agent.sock"
listen_socket "${SSH_AUTH_SOCK}"

# GPG
export GPG_AGENT_SOCK="${HOME}/.gnupg/S.gpg-agent"
listen_socket "${GPG_AGENT_SOCK}" --gpg S.gpg-agent

# GPG extra for agent forwarding to devcontainers in VS Code
export GPG_AGENT_SOCK_EXTRA="${HOME}/.gnupg/S.gpg-agent.extra"
listen_socket "${GPG_AGENT_SOCK_EXTRA}" --gpg S.gpg-agent.extra

unset wsl2_ssh_pageant_bin

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

if [[ -f "$HOME/.config/bash/.bash_private" ]]; then
    source "$HOME/.config/bash/.bash_private"
fi

for file in $HOME/.config/bash/*.sh; do
  source "$file"
done

for file in $HOME/.config/bash_wsl/*.sh; do
  source "$file"
done

# check if secrets exists
if [ -d $HOME/.config/secrets ]; then
  for file in $HOME/.config/secrets/*.sh; do
    source "$file"
  done
fi

[ -f ~/.bash_lumen ] && source ~/.bash_lumen
[ -f ~/.fzf.bash ]   && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#    exec tmux new-session -A -s main
#fi

# Adapted from https://unix.stackexchange.com/a/113768/347104
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
fi
. "$HOME/.cargo/env"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

toilet "Helto4Real" -F border:metal -f emboss2
