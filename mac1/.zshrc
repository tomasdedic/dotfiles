# zmodload zsh/zprof #load profiler
# export TERM=xterm-256color
export DISPLAY=:0
export GOPATH=$HOME/go
export EDITOR=nvim
export LC_ALL=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/opt/homebrew/share/zsh-syntax-highlighting/highlighters"
export ZSH="$HOME/.oh-my-zsh"
eval $(/opt/homebrew/bin/brew shellenv)
ZSH_THEME="fishy"


# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true
# Uncomment the following line to enable command auto-correction.
export ENABLE_CORRECTION="false"
unsetopt correctall

# field separator
setopt SH_WORD_SPLIT
#ve skriptu lze pouzit
#for i in ${=xxx}; do echo "ss: ${i}";done
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

#HISTORY
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY_TIME
# setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS

setopt NOINCAPPENDHISTORY
setopt NOSHAREHISTORY


# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/

plugins=(
	   vi-mode
     zsh-history-substring-search
     zsh-syntax-highlighting
     zsh-autosuggestions
     fzf
	   # git
     #zsh-vi-mode
     # z
     kube-ps1
     # zshmarks
     golang
)

# KUBE-PS1
export KUBE_PS1_BINARY=kubectl
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_NS_ENABLE=true

# autosuggestion color: the default fg=8 is #424242 in Ghostty "Pencil Light",
# the same as normal text, so use an explicit light gray
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#9e9e9e'

export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_NORMAL=2   # steady block
VI_MODE_CURSOR_INSERT=2   # steady block
VI_MODE_CURSOR_VISUAL=2   # steady block
source $ZSH/oh-my-zsh.sh
# bindkey "^X" forward-word #jump word by word (use Ctrl-F; ^X is the prefix of ^Xa, ^Xe, ...)
# Ctrl-X shortcuts (zsh completion widgets; ^X alone is unbound, so no timeout):
#   Ctrl-X a  expand alias under cursor           ll -> ls -lh
#   Ctrl-X e  expand word: glob, $VAR, ~, $(cmd)  *.py -> a.py b.py
#   Ctrl-X m  insert most recently modified file  tar xzf <newest file>
#   Ctrl-X d  list expansions, leave the word as it is
#   Ctrl-X c  spelling correction of the word
#   Ctrl-X h  completion help for the cursor position
bindkey '^F' forward-word  # Ctrl-f (Alt-f is AeroSpace fullscreen)
bindkey '^B' backward-word # Ctrl-b
eval $(gdircolors ~/.config/dircolors.ansi-dark)

export HELM_REGISTRY_CONFIG=~/.config/helm/registry.json
export HELM_REPOSITORY_CONFIG=~/.config/helm/repositories.yaml

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi


export DISABLE_MAGIC_FUNCTIONS=true
export FZF_BASE="$HOME/.fzf"

export PATH="$HOME/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin/:/opt/homebrew/opt/findutils/libexec/gnubin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH:$LSPPATH:/usr/local/bin:/usr/X11/bin:$GOPATH/bin:$HOME/.local/bin"
export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# select files with tab and delete
rmf() {
    ls -p | fzf -m | while read filename; do rm -rf $filename; done
}

export SUDO_ASKPASS=/usr/bin/ssh-askpass
# history search by any part of the command (zsh-history-substring-search plugin)
# ^[[A/^[[B = arrows in normal cursor mode, ^[OA/^[OB = arrows in application mode
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# vi-mode: blue cursor outside insert mode. Wraps the vi-mode plugin function that runs on
# every mode change; OSC 12 sets the cursor color, OSC 112 resets it to the terminal default.
# Nvim's terminal drops OSC 112, so inside Nvim ($NVIM set) the reset is sent as OSC 12 "default".
functions[_vi-mode-shape-orig]=$functions[_vi-mode-set-cursor-shape-for-keymap]
_vi-mode-set-cursor-shape-for-keymap() {
  _vi-mode-shape-orig "$@"
  case "${1:-${VI_KEYMAP:-main}}" in
    vicmd|visual|viopp) printf '\e]12;#1e66f5\a' ;;
    *) if [[ -n $NVIM ]]; then printf '\e]12;default\a'; else printf '\e]112\a'; fi ;;
  esac
}

# Transient prompt: the prompt you type at is the full two-line theme prompt; after Enter it is
# redrawn as just "➤ <command>", so scrollback shows commands and the info line appears once.
_prompt_full=$PROMPT
_prompt_restore() { PROMPT=$_prompt_full }
_prompt_transient() {
  PROMPT='%{$reset_color%}➤ '
  zle reset-prompt
}
autoload -Uz add-zsh-hook add-zle-hook-widget
add-zsh-hook precmd _prompt_restore
add-zle-hook-widget zle-line-finish _prompt_transient
export HOWDOI_COLORIZE=1
FPATH=~/.zsh.d:$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
# autoload -U compinit
# compinit -i
## completion
# setopt complete_aliases
alias compdef kb='kubectl'
compdef kb='kubectl'
# autoload -Uz +X compinit
# compinit -i

ulimit -n 10240
export KIND_EXPERIMENTAL_PROVIDER=podman
# make cd commant good agin
eval "$(zoxide init zsh)"

#DECSCUSR
echo -e -n "\x1b[\x32 q" #changes to steady block cursor
# . "$HOME/.cargo/env"
HOMEBREW_NO_VERIFY_ATTESTATIONS=1
# zprof #profiler output

# bun completions
[ -s "/Users/ext90981/.bun/_bun" ] && source "/Users/ext90981/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude-mem='/Users/ext90981/.bun/bin/bun "/Users/ext90981/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# publish KUBECONFIG to the tmux pane so new splits can inherit it (see ~/.tmux.conf binds | - _)
autoload -Uz add-zsh-hook
_tmux_pub_kubeconfig() {
  [[ -n $TMUX && $KUBECONFIG != $_tmux_last_kubeconfig ]] || return
  tmux set -p @kubeconfig "$KUBECONFIG" && _tmux_last_kubeconfig=$KUBECONFIG
}
add-zsh-hook precmd _tmux_pub_kubeconfig
#aliases
alias ls='gls --color=auto'
alias ansible-lint="ansible-lint -c ~/.config/ansible-lint"

# Auto activate virtual environment if in a project directory with a venv folder
   function auto_activate_venv() {
       for venv_dir in .venv venv; do
           if [[ -f "$venv_dir/bin/activate" ]]; then
               source "$venv_dir/bin/activate"
               return
           fi
       done
   }

# Trigger auto_activate_venv function on directory change
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_venv
