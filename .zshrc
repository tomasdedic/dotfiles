# profiler
# zmodload zsh/zprof
# export TERM=xterm-256color
export DISPLAY=:0
#golang
export GOPATH=$HOME/go
export EDITOR="/usr/local/bin/nvim"
# If you come from bash you might have to change your $PATH.
#ZSH_THEME="powerlevel10k/powerlevel10k"
export LC_ALL=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/opt/homebrew/share/zsh-syntax-highlighting/highlighters"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fishy"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
export ENABLE_CORRECTION="false"
unsetopt correctall
# field separator
setopt SH_WORD_SPLIT
#ve skriptu lze pouzit
#for i in ${=xxx}; do echo "ss: ${i}";done
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
#source ${ZSH_CUSTOM}/run_complete.sh
# source  ${ZSH_CUSTOM}/oc_completion.sh

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


# Which plugins would you like to load?
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
export KUBE_PS1_BINARY=oc
export KUBE_PS1_SYMBOL_ENABLE=true

export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1
source $ZSH/oh-my-zsh.sh
# source ${ZSH_CUSTOM}/run_complete.sh
#ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
# one world to right in autocomplete sugestions
bindkey "^X" forward-word
# User configuration
# partial completion suggestions
# zstyle ':completion:*' list-suffixes
# zstyle ':completion:*' expand prefix suffix
# export MANPATH="/usr/local/man:$MANPATH"
ENABLE_CORRECTION="true"
eval $(gdircolors ~/.config/dircolors.ansi-dark)

export HELM_REGISTRY_CONFIG=~/.config/helm/registry.json
export HELM_REPOSITORY_CONFIG=~/.config/helm/repositories.yaml

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi
# setopt complete_aliases
alias compdef kb='kubectl'
compdef kb='kubectl'

export DISABLE_MAGIC_FUNCTIONS=true
export FZF_BASE="$HOME/.fzf"

export PATH="$HOME/bin:/usr/local/opt/grep/libexec/gnubin/:${KREW_ROOT:-$HOME/.krew}/bin:$PATH:$LSPPATH:/usr/local/bin:/usr/X11/bin:$GOPATH/bin:$HOME/.local/bin:$HOME/.cargo/bin"
export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# select files with tab and delete
rmf() {
    ls -p | fzf -m | while read filename; do rm -rf $filename; done
}

export SUDO_ASKPASS=/usr/bin/ssh-askpass
# profiler output
# zprof
#
bindkey "^[OA" up-history
bindkey "^[OB" down-history
export HOWDOI_COLORIZE=1
FPATH=$(brew --prefix)/share/zsh-completion:~/.zsh.d/:$FPATH
autoload -Uz +X compinit
compinit
#set open files limit
ulimit -n 10240
export KIND_EXPERIMENTAL_PROVIDER=podman
# make cd commant good agin
eval "$(zoxide init zsh)"


. "$HOME/.cargo/env"
