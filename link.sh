#!/bin/bash

# アプリやツール等の設定ファイルのシンボリックリンクを貼るスクリプト

# 一旦シンボリックリンクをベタで書く
# TODO: 整ったらリファクタする

# オペレーティングシステムを判定
OS="$(uname)"

if [ ! -d "$HOME/.config" ]; then
	mkdir "$HOME/.config"
fi

########## espanso
ln -sfv $HOME/Dropbox/AppConfig/espanso/match/base.yml $HOME/Library/Application\ Support/espanso/match/base.yml
ln -sfv $HOME/Dropbox/AppConfig/espanso/config/default.yml $HOME/Library/Application\ Support/espanso/config/default.yml

########## karaviner-elements
cp -r $HOME/.config/karabiner/assets $HOME/.config/karabiner/assets.org
rm -rdf $HOME/.config/karabiner/assets
ln -sfv $HOME/Dropbox/AppConfig/karaviner/assets/ $HOME/.config/karabiner/assets
ln -sfv $HOME/Dropbox/AppConfig/karaviner/karabiner.json $HOME/.config/karabiner/karabiner.json

########## japanese input
cp -r $HOME/Library/Application\ Support/Google/JapaneseInput $HOME/Library/Application\ Support/Google/JapaneseInput.org
rm -rdf $HOME/Library/Application\ Support/Google/JapaneseInput
ln -sfv $HOME/Dropbox/AppConfig/JapaneseInput/ $HOME/Library/Application\ Support/Google/JapaneseInput

########## zsh
ln -sfv $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -sfv $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv
ln -sfv $HOME/dotfiles/zsh/.zprofile $HOME/.zprofile

#OSごとの処理
if [ $OS == "Linux" ]; then
	# Linuxの場合の処理
	ln -sfv $HOME/dotfiles/zsh/.zshrc.linux $HOME/.zshrc.linux
elif [ $OS == "Darwin" ]; then
	# macOSの場合の処理
	ln -sfv $HOME/dotfiles/zsh/.zshrc.mac $HOME/.zshrc.mac
else
	echo "Unsupported OS."
fi

########## git
ln -sfv $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -sfv $HOME/dotfiles/git/.gitignore_global $HOME/.gitignore_global
cp $HOME/dotfiles/git/.gitconfig.local.template $HOME/.gitconfig.local
cp $HOME/dotfiles/git/.gitmessage.local.template $HOME/.gitmessage.local

########## nvim
# 対象のディレクトリ
nvimConfigDir="$HOME/.config/nvim"
# 対象がシンボリックリンクかどうかを確認
# 条件分岐にしないとシンボリックリンク先の中にシンボリックリンクが貼られる
if [ -L "$nvimConfigDir" ]; then
	# 対象がシンボリックリンクの場合
	echo "$nvimConfigDir はすでにシンボリックリンクです。"
else
	# 対象がシンボリックリンクでない場合、リンクを作成
	ln -sfv $HOME/dotfiles/nvim $HOME/.config/nvim
	echo "$nvimConfigDir へのシンボリックリンクを $target に作成しました。"
fi

########## starship
ln -sfv $HOME/dotfiles/starship/starship.toml $HOME/.config/starship.toml

########## sheldon
if [ ! -d "$HOME/.config/sheldon" ]; then
	mkdir "$HOME/.config/sheldon"
fi
ln -sfv $HOME/dotfiles/sheldon/plugins.toml $HOME/.config/sheldon/plugins.toml

########## tmux
ln -sfv $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

echo "DONE"
