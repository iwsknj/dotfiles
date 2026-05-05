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

########## yazi
if [ -L "$HOME/.config/yazi" ]; then
	echo "$HOME/.config/yazi はすでにシンボリックリンクです。"
else
	ln -sfv $HOME/dotfiles/yazi $HOME/.config/yazi
fi

########## grip
if [ ! -d "$HOME/.grip" ]; then
	mkdir -p "$HOME/.grip"
fi
ln -sfv $HOME/dotfiles/grip/preview.sh $HOME/.grip/preview.sh
ln -sfv $HOME/dotfiles/grip/settings.py $HOME/.grip/settings.py

########## mo
if [ ! -d "$HOME/.mo" ]; then
	mkdir -p "$HOME/.mo"
fi
ln -sfv $HOME/dotfiles/mo/preview.sh $HOME/.mo/preview.sh

########## bin scripts
if [ ! -d "$HOME/.local/bin" ]; then
	mkdir -p "$HOME/.local/bin"
fi
ln -sfv $HOME/dotfiles/bin/cmux-setup $HOME/.local/bin/cmux-setup
ln -sfv $HOME/dotfiles/bin/git-watch $HOME/.local/bin/git-watch

########## claude
ln -sfv $HOME/dotfiles/claude/CLAUDE.md $HOME/.claude/CLAUDE.md
ln -sfv $HOME/.claude/CLAUDE.md $HOME/AGENTS.md
ln -sfv $HOME/dotfiles/claude/settings.json $HOME/.claude/settings.json

claudeSkillsDir="$HOME/.claude/skills"
if [ -L "$claudeSkillsDir" ]; then
	echo "$claudeSkillsDir はすでにシンボリックリンクです。"
else
	ln -sfv $HOME/dotfiles/claude/skills $HOME/.claude/skills
fi

########## codex
codexSkillsDir="$HOME/.codex/skills"
if [ -L "$codexSkillsDir" ]; then
	echo "$codexSkillsDir はすでにシンボリックリンクです。"
else
	if [ -e "$codexSkillsDir" ]; then
		mv "$codexSkillsDir" "$HOME/.codex/skills.bak"
	fi
	ln -sfv $HOME/dotfiles/codex/skills $HOME/.codex/skills
fi

echo "DONE"
