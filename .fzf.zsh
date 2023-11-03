# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/ts/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/ts/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/ts/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/ts/.fzf/shell/key-bindings.zsh"
