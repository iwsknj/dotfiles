#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...


# refere to suin
# https://suin.io/568
: "一般的な設定" && {
  autoload -U compinit && compinit      # 補完機能の強化
  setopt correct                        # 入力しているコマンド名が間違っている場合にもしかして：を出す。
  setopt nobeep                         # ビープを鳴らさない
  setopt no_tify                        # バックグラウンドジョブが終了したらすぐに知らせる。
  unsetopt auto_menu                    # タブによるファイルの順番切り替えをしない
  setopt auto_pushd                     # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
  setopt auto_cd                        # ディレクトリ名を入力するだけでcdできるようにする
  setopt interactive_comments           # コマンドラインでも # 以降をコメントと見なす
}

: "ヒストリ関連の設定" && {
  setopt hist_ignore_dups               # 直前と同じコマンドをヒストリに追加しない
  setopt hist_ignore_all_dups           # 重複するコマンドは古い法を削除する
  setopt share_history                  # 異なるウィンドウでコマンドヒストリを共有する
  setopt hist_no_store                  # historyコマンドは履歴に登録しない
  setopt hist_reduce_blanks             # 余分な空白は詰めて記録
  setopt hist_verify                    # `!!`を実行したときにいきなり実行せずコマンドを見せる
}

: "補完の設定" && {
	setopt auto_param_slash         # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
	setopt mark_dirs                # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
	setopt list_types               # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
	setopt auto_menu                # 補完キー連打で順に補完候補を自動で補完
	setopt auto_param_keys          # カッコの対応などを自動的に補完
	setopt interactive_comments     # コマンドラインでも # 以降をコメントと見なす
	setopt magic_equal_subst        # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

	setopt complete_in_word         # 語の途中でもカーソル位置で補完
	setopt always_last_prompt       # カーソル位置は保持したままファイル名一覧を順次その場で表示
}

: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd `fgrep 'Host ' ~/.ssh/*/config ~/.ssh/*/*/config | grep -v '*' | awk '{print $2}' | sort` }
}


autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
function _update_vcs_info_msg()
{
psvar=()
LANG=en_US.UTF-8 vcs_info
psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%v"

#less
export LESSCHARSET=utf-8

#fuel env
export FUEL_ENV=kenji_dev

#php path
export PATH="$(brew --prefix homebrew/core/php@7.1)/bin:$PATH"

#php composer path
export PATH=$PATH:~/.composer/vendor/bin/

#node path
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:./node_modules/.bin

#rbenv path
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

#utility

	alias 1='cd ..'
	alias 2='cd ../..'
	alias 3='cd ../../..'
	alias 4='cd ../../../..'
	alias 5='cd ../../../../..'
	alias 6='cd ../../../../../..'

	alias su='sudo'
	alias sui='sudo -i'



#vagrant

	alias va='vagrant'
	alias vst='vagrant status'
	alias vs='vagrant ssh'
	alias vr='vagrant reload'
	alias vra='vagrant rsync-auto'
	alias vu='vagrant up'
	alias vh='vagrant halt'
	alias vsus='vagrant suspend'
	alias vpi='vagrant plugin install'
	alias vpl='vagrant plugin list'
	alias vbr='vagrant box remove'
	alias vbl='vagrant box list'
	alias vbi='vagrant box init'
	alias vv='vagrant -v'


#Git

	alias graph="log --graph --date-order --all --pretty=format:'%h %Cred%d %Cgreen%ad %Cblue%cn %Creset%s' --date=short"

	alias g='git'
	alias gg='git graph'
	alias gl='git log'
	alias gs='git status'
	alias gi='git init'

	##branch
	alias gb='git branch'
	alias gch='git checkout'
	alias gchb='git checkout -b'
	alias gbd='git branch --delete'
	alias gba='git branch --all'

	##comit
	alias ga='git add'
	alias gaa='git add .'
	alias gc='git commit'
	alias gcm='git commit -m'
	alias gca='git commit --amend -m'

	##merge
	alias gm='git merge'
	alias gmnc='git merge --no-commit'
	alias gmnf='git merge --no-ff'

	##fetch
	alias gf='git fetch'
	alias gcl='git clone'
	alias gpl='git pull'

	##push
	alias gps='git push'
	alias gpsf='git push --force'
	alias gpsa='git push --all'

	##rebase
	alias gr='git rebase'


# Vim
	alias v='vim'
	alias vi='vim'

# Docker
	alias d='docker'
	alias dc='docker-compose'
