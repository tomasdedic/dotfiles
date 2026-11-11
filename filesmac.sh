#!/usr/bin/env zsh
# Snapshot this mac's dotfiles into <machine>/ for the repo. Usage: filesmac2.sh mac1|mac2
set -e
cd "$(dirname "$0")"
d=${1:?usage: filesmac2.sh mac1|mac2}
mkdir -p $d/.config $d/.oh-my-zsh/themes $d/.pi/agent
cp ~/.aerospace.toml ~/.zshrc ~/.zshenv ~/.tmux.conf ~/.gitconfig $d/
cp -r ~/.config/dircolors* ~/.config/nvim ~/.config/ghostty \
      ~/.config/yamllint ~/.config/ruff ~/.config/.ansible-lint $d/.config/
cp -r ~/.oh-my-zsh/themes/fishy.zsh-theme $d/.oh-my-zsh/themes/
# models.json is safe to store: every apiKey here is $ENV or a !command, never a literal
cp ~/.pi/agent/{settings.json,models.json,AGENTS.md} $d/.pi/agent/
# Per-machine package list. Restore on a new mac: brew bundle install --file=<machine>/Brewfile
brew bundle dump --force --file="$d/Brewfile"
echo "ok: $(find $d -type f | wc -l | tr -d ' ') files in $d/, Brewfile $(wc -l <"$d/Brewfile" | tr -d ' ') lines"
