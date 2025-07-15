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

export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1
source $ZSH/oh-my-zsh.sh
bindkey "^X" forward-word #jump word by word
eval $(gdircolors ~/.config/dircolors.ansi-dark)

export HELM_REGISTRY_CONFIG=~/.config/helm/registry.json
export HELM_REPOSITORY_CONFIG=~/.config/helm/repositories.yaml

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi


export DISABLE_MAGIC_FUNCTIONS=true
export FZF_BASE="$HOME/.fzf"

export PATH="$HOME/bin:/usr/local/opt/grep/libexec/gnubin/:${KREW_ROOT:-$HOME/.krew}/bin:$PATH:$LSPPATH:/usr/local/bin:/usr/X11/bin:$GOPATH/bin:$HOME/.local/bin"
export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# select files with tab and delete
rmf() {
    ls -p | fzf -m | while read filename; do rm -rf $filename; done
}

export SUDO_ASKPASS=/usr/bin/ssh-askpass
bindkey "^[OA" up-history
bindkey "^[OB" down-history
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
