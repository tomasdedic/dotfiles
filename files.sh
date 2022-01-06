#!/usr/bin/env zsh
cp -r ~/.config/openbox ./.config/
cp -r ~/.config/startupscripts ./.config/
cp -r ~/.config/bunsen ./.config/
cp -r ~/.config/nvim ./.config/
cp -r ~/.screenlayout ./.screenlayout
cp -r ~/.tmux/customscripts ./.tmux
if [[ ! -d .config/Code/User ]];then
  mkdir -p .config/Code/User/
fi
cp ~/.config/Code/User/keybindings.json ./.config/Code/User
cp ~/.config/Code/User/settings.json ./.config/Code/User

# cp -r ~/.tmux/plugins ./.tmux/plugins
cp -r ~/.config/dmenu-extended ./.config/
if [[ ! -d .oh-my-zsh/themes ]];then
  mkdir -p ./oh-my-zsh/themes/
fi
cp -r ~/.oh-my-zsh/themes/fishy.zsh-theme ./.oh-my-zsh/themes
# cp -r ~/.oh-my-zsh/custom/ ./.oh-my-zsh
#cp -r ~/.ssh ./.ssh
cp -r ~/.zsh.d ./.zsh.d
cp -r ~/.zshrc ./.zshrc
cp -r ~/.tmux.conf ./.tmux.conf
cp -r ~/.ctags.d/ ./
cp -r ~/.bash_aliases ./
cp ~/.vimrc ./.vimrc
cp ~/.fzf.zsh ./.fzf.zsh
cp -r ~/.config/yamllint/config ./.config/yamllint/
