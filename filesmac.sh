#!/usr/bin/env zsh
rm -rf ./.config
rm -rf ./.oh-my-zsh
rm -rf ./.ctags.d
rm -rf ./.zsh.d
mkdir -p .config
mkdir -p .oh-my-zsh/themes

cp -r ~/.oh-my-zsh/themes/fishy.zsh-theme ./.oh-my-zsh/themes
cp -r ~/.config/nvim ./.config/nvim
cp -r ~/.zshrc ./.zshrc
cp -r ~/.tmux.conf ./.tmux.conf
cp -r ~/.ctags.d/ ./
cp -r ~/.gitconfig ./.gitconfig
cp -r ~/.zsd.d /.zsh.d
cp  ~/.config/* ./.config 2>/dev/null
cp -r ~/.config/iterm2 ./.config/iterm2
cp -r ~/.config/yamllint ./.config/yamllint
