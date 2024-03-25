#!/bin/bash

# 一旦シンボリックリンクをベタで書く
# TODO: 整ったらリファクタする

# オペレーティングシステムを判定
OS="$(uname)"

if [ ! -d "$HOME/.config" ]; then
	mkdir "$HOME/.config"
fi

# zsh
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv

# git
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/git/.gitignore_global $HOME/.gitignore_global
cp $HOME/dotfiles/git/.gitconfig.local.template $HOME/.gitconfig.local
cp $HOME/dotfiles/git/.gitmessage.local.template $HOME/.gitmessage.local

# nvim
# 対象のディレクトリ
nvimConfigDir="$HOME/.config/nvim"
# 対象がシンボリックリンクかどうかを確認
# 条件分岐にしないとシンボリックリンク先の中にシンボリックリンクが貼られる
if [ -L "$nvimConfigDir" ]; then
	# 対象がシンボリックリンクの場合
	echo "$nvimConfigDir はすでにシンボリックリンクです。"
else
	# 対象がシンボリックリンクでない場合、リンクを作成
	ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
	echo "$nvimConfigDir へのシンボリックリンクを $target に作成しました。"
fi

# starship
ln -s $HOME/dotfiles/starship/starship.toml $HOME/.config/starship.toml

# sheldon
if [ ! -d "$HOME/.config/sheldon" ]; then
	mkdir "$HOME/.config/sheldon"
fi
ln -s $HOME/dotfiles/sheldon/plugins.toml $HOME/.config/sheldon/plugins.toml

# tmux
ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

# OSごとの処理
if [ $OS == "Linux" ]; then
	# Linuxの場合の処理
	ln -s $HOME/dotfiles/zsh/.zshrc.linux $HOME/.zshrc.linux
elif [ $OS == "Darwin" ]; then
	# macOSの場合の処理
	ln -s $HOME/dotfiles/zsh/.zshrc.mac $HOME/.zshrc.mac
else
	echo "Unsupported OS."
fi
