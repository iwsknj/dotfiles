#!/bin/bash

set -u

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

cd $THIS_DIR

echo "start setup..."
for f in .??*; do
	[ "$f" = ".git" ] && continue
	[ "$f" = ".gitconfig.local.template" ] && continue
	[ "$f" = ".gitmessage.local.template" ] && continue

	ln -snfv ~/dotfiles/"$f" ~
done

[ -e ~/.gitconfig.local ] || cp ~/dotfiles/.gitconfig.local.template ~/.gitconfig.local
[ -e ~/.gitmessage.local ] || cp ~/dotfiles/.gitmessage.local.template ~/.gitmessage.local

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END
