# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ts/utils/compiled_software/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ts/utils/compiled_software/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ts/utils/compiled_software/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ts/utils/compiled_software/fzf/shell/key-bindings.zsh"
