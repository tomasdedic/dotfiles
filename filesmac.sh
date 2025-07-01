#!/usr/bin/env zsh
rm -rf ./.config
rm -rf ./.oh-my-zsh
# rm -rf ./.ctags.d
# rm -rf ./.zsh.d
mkdir -p .config
mkdir -p .oh-my-zsh/themes

cp ~/.aerospace.toml ./.aerospace.toml
cp ~/.config/dircolors* ./.config
cp -r ~/.config/alacritty ./.config/alacritty
cp -r ~/.oh-my-zsh/themes/fishy.zsh-theme ./.oh-my-zsh/themes
cp -r ~/.config/nvim ./.config/nvim
cp -r ~/.config/nvim.bak ./.config/nvim.bak
cp -r ~/.config/ghostty ./.config/ghostty
cp -r ~/.zshrc ./.zshrc
cp -r ~/.zshenv ./.zshenv
cp -r ~/.tmux.conf ./.tmux.conf
# cp -r ~/.ctags.d/ ./
cp -r ~/.gitconfig ./.gitconfig
# cp -r ~/.zsh.d /.zsh.d
# cp  ~/.config/* ./.config 2>/dev/null
# cp -r ~/.config/iterm2 ./.config/iterm2
cp -r ~/.config/yamllint ./.config/yamllint
cp -r ~/.claude ./.config/.claude
