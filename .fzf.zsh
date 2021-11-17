# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ts/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ts/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ts/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ts/.fzf/shell/key-bindings.zsh"
