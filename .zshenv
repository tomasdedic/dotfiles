export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
export SNACKS_GHOSTTY=true
alias rm=trash
alias cr='cd $(git rev-parse --show-toplevel)'
alias dog='git log --all --decorate --oneline --graph'
#git config --global alias.lg1 'log --all --decorate --oneline --graph'
# alias doga='git log --oneline --decorate --color --graph --all --author-date-order --pretty=format:"%C(auto)%h %d %s %C(green)(%ad)" --date=format:"%H:%M:%S"'
alias doga='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
# git config --global alias.lg2 'log --graph --abbrev-commit --decorate --format=format:''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'' --all'

alias sed='gsed'
alias dircolors='gdircolors'
# eval $(dircolors ~/.config/dircolors.ansi-dark)
alias setkey='~/.config/startupscripts/setkeyboard'
alias neat='kubectl neat'
alias ls='gls --color=auto'
alias kn='kubectl config view --minify --output 'jsonpath={..namespace}'; echo'
alias tmux='tmux -2'
alias gdoc='gopherdoc'
alias -g pbcopy='xclip -selection clipboard'
alias -g pbpaste='xclip -selection clipboard -o'
alias las='history -1|awk "{\$1=\"\";print substr(\$0,2)}"|xclip -selection clipboard'
alias kb='kubectl'
alias pb='tmux loadb -'
alias xin='xinput --disable $(xinput list --id-only "Synaptics TM3276-022")'
alias hr="fc -RI" #sync history
alias cat="bat -p --theme GitHub"
# alias docker=podman
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
alias vim='nvim'
alias vi='nvim'
alias ym='vim -c "set ft=yaml"'
# setopt complete_aliases
alias compdef kb='kubectl'
alias paks='source ~/bin/paks'

fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  local file=$(rg --files-with-matches --ignore-case --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"|awk '{print $1}')
  vim $file
}

function ctx() {
  local pathtoconfig="$HOME/.kube/confignopass"
  local kbconfig
  kbconfig=$(find  $pathtoconfig -type f -name \*-config | xargs basename | sort | fzf -q "$1")
  # export cannot be returned back to parent process, source workaround
  [ -n "$kbconfig" ] && (echo "export KUBECONFIG=$pathtoconfig/$kbconfig" >~/tmp/kube) \
  && printf '%b\n' "\033[1m"$pathtoconfig/$kbconfig"\033[0m"
  source ~/tmp/kube

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

function grt()
{
    git rev-parse --show-toplevel
}
