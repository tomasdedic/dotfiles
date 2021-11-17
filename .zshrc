# profiler
#zmodload zsh/zprof
export TERM=xterm-256color
#golang
export GOPATH=$HOME/go
export EDITOR="/usr/local/bin/nvim"
# If you come from bash you might have to change your $PATH.
export PATH=/opt/Citrix/ICAClient:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/go/bin:$GOPATH/bin:/usr/local/kubebuilder/bin:$PATH
#ZSH_THEME="powerlevel10k/powerlevel10k"
export LC_ALL=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH="/home/ts/.oh-my-zsh"

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
export ZSH_CUSTOM=~/.oh-my-zsh/custom
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
     docker
     kubectl
     helm
     fzf
	   git
     zsh-vim-mode
     z
     kube-ps1
     zshmarks
     golang
)
# KUBE-PS1
export KUBE_PS1_BINARY=oc
export KUBE_PS1_SYMBOL_ENABLE=false

export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/share/zsh-syntax-highlighting/highlighters
source $ZSH/oh-my-zsh.sh
source <(oc completion zsh)
source ${ZSH_CUSTOM}/run_complete.sh
#ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
bindkey "^ " forward-word
# User configuration
# partial completion suggestions
# zstyle ':completion:*' list-suffixes
# zstyle ':completion:*' expand prefix suffix
# export MANPATH="/usr/local/man:$MANPATH"
ENABLE_CORRECTION="true"
alias setkey='~/.config/startupscripts/setkeyboard'
alias tmux='tmux -2'
alias gdoc='gopherdoc'
alias -g pbcopy='xclip -selection clipboard'
alias -g pbpaste='xclip -selection clipboard -o'
alias las='history -1|awk "{\$1=\"\";print substr(\$0,2)}"|xclip -selection clipboard'
alias kb='kubectl'
alias pb='xclip -selection clipboard'
alias xin='xinput --disable $(xinput list --id-only "Synaptics TM3276-022")'
alias hr="fc -RI" #sync history
alias viq="urxvt -e vim "
alias v='nvim'
alias cat="bat -p --theme GitHub"
alias docker=podman
alias bc='bc -l'
alias zshconfig="source ~/.zshrc"
alias dirs='dirs -v'
alias d='dirs -v|head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

#local exported env
export ocpdoc=$(echo ~/git_repositories/moje/madopenshift/content/openshift/)
export oshi=$(echo ~/git_repositories/work/openshift/oshi/)

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi
compdef kb='kubectl'
setopt complete_aliases


export DISABLE_MAGIC_FUNCTIONS=true
export FZF_BASE="$HOME/.fzf"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# select files with tab and delete
rmf() {
    ls -p | fzf -m | while read filename; do rm -rf $filename; done
}

hugohard() {
  HUGO_STASH_REPOSITORY='/home/ts/git_repositories/moje/madopenshift/content/faze'
  echo "linking $(pwd) to $HUGO_STASH_REPOSITORY"
  ln -s $(pwd) $HUGO_STASH_REPOSITORY/
}

fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  local file=$(rg --files-with-matches --ignore-case --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"|awk '{print $1}')
  vim $file
}

# Select a running docker container to stop
function pos() {
  local cid
  cid=$(podman ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && (set -x; podman stop "$cid")
}
# Select a docker container to remove
function poirm() {
  local cid
  cid=$(podman images | sed 1d | fzf -q "$1"  | awk '{print $3}')

  [ -n "$cid" ] && (set -x; podman rmi "$cid")
}

# select podman image, run it with bash
function poir() {
  local cid
  # cid=$(podman images | sed 1d | fzf -q "$1" | awk '{print $3}')
  cid=$(podman images | sed 1d | fzf | awk '{print $3}')

  [ -n "$cid" ] && (set -x; podman run --rm -it "$cid" "${@:-bash}")
}

function ya() {
ff=$(ls *.yaml | fzf -q "$1" )
cc=$(echo '' | fzf --print-query --preview "cat $ff|yq e {q} -")
yq e $cc $ff
}

function azctx() {
    local sub
    sub=$(az account list --query "[].name" -o tsv | sort -f | fzf -q "$1")
    [ -n "$sub" ] && az account set --subscription "$sub"
}

#pet register
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}
#pet search
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

export SUDO_ASKPASS=/usr/bin/ssh-askpass
# profiler output
#zprof
#
bindkey "^[OA" up-history
bindkey "^[OB" down-history
export HOWDOI_COLORIZE=1

export PATH=$PATH:/home/ts/bin
autoload -U compinit; compinit
source '/home/ts/lib/azure-cli/az.completion'
# custom comletion
fpath=(~/.zsh.d/ $fpath)


alias luamake=/home/ts/tmp/luamake/luamake
