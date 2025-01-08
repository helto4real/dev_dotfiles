# Setup fzf
# ---------
if [[ ! "$PATH" == */home/thhel/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/thhel/.fzf/bin"
fi

eval "$(fzf --bash)"
