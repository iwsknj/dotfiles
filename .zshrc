# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
	HISTFILE=$HOME/.zsh_history # ヒストリファイル名
  HISTSIZE=10000 # メモリに保存される履歴の件数
  SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数
	HISTTIMEFORMAT='%F %T '
	HISTIGNORE='history:pwd:ls:ls *:ll:w:top:df *'
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

# OS判定
case ${OSTYPE} in
	# for mac setting
	 darwin*)

	 		##### tmux #########
			 function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
			function is_osx() { [[ $OSTYPE == darwin* ]]; }
			function is_screen_running() { [ ! -z "$STY" ]; }
			function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
			function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
			function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
			function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

			function tmux_automatically_attach_session()
			{
			 if is_screen_or_tmux_running; then
				 ! is_exists 'tmux' && return 1

				 if is_tmux_runnning; then
					 echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
					 echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
					 echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
					 echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
					 echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
				 elif is_screen_running; then
					 echo "This is on screen."
				 fi
			 else
				 if shell_has_started_interactively && ! is_ssh_running; then
					 if ! is_exists 'tmux'; then
						 echo 'Error: tmux command not found' 2>&1
						 return 1
					 fi

					 if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
						 # detached session exists
						 tmux list-sessions
						 echo -n "Tmux: attach? (y/N/num) "
						 read
						 if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
							 tmux attach-session
							 if [ $? -eq 0 ]; then
								 echo "$(tmux -V) attached session"
								 return 0
							 fi
						 elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
							 tmux attach -t "$REPLY"
							 if [ $? -eq 0 ]; then
								 echo "$(tmux -V) attached session"
								 return 0
							 fi
						 fi
					 fi

					 if is_osx && is_exists 'reattach-to-user-namespace'; then
						 # on OS X force tmux's default command
						 # to spawn a shell in the user's namespace
						 tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
						 tmux -f <(echo "$tmux_config") new-session \; source-file ~/dotfiles/tmuxinit && echo "$(tmux -V) created new session supported OS X"
					 else
						 tmux new-session && echo "tmux created new session"
					 fi
				 fi
			 fi
			}
			# tmuxの自動起動設定
			# tmux_automatically_attach_session
			##### end tmux #########

		 : "sshコマンド補完を~/.ssh/configから行う" && {
		   function _ssh { compadd `fgrep 'Host ' ~/.ssh/*/config ~/.ssh/*/*/config | grep -v '*' | awk '{print $2}' | sort` }
		 }

		#homebrew
		export PATH=$HOME/.homebrew/bin:$PATH
		export HOMEBREW_CACHE=$HOME/.homebrew/caches
		# export PATH=/Users/KenjiIwase/.homebrew/opt/openssl/bin:$PATH # for openssl

		#less
		export LESSCHARSET=utf-8

		#fuel env
		export FUEL_ENV=kenji_dev

		#php path
		export PATH="$(brew --prefix homebrew/core/php@7.1)/bin:$PATH"

		#php composer path
		export PATH=$PATH:~/.composer/vendor/bin/


		#nvm （プロジェクトごとにバージョンを変えたい場合は.nvmrcにバージョンを書き nvm useをする
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


		#node path
		export PATH=$PATH:./node_modules/.bin

		#rbenv path
		# (homebrewをhomedirにinstallしている場合は以下を付けてインストールする)
		# CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl`" rbenv install [2.3.4]
		export PATH=$HOME/.rbenv/bin:$PATH
		eval "$(rbenv init -)"

		# for pyenv
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/bin:$PATH"
		export PIPENV_VENV_IN_PROJECT=1
		eval "$(pyenv init -)"

		# for golang (vscodeのcode workspaceの機能を使うと上書きされるからコメントアウト)
		# export GOPATH="$HOME/go"
		# export PATH="$PATH:$GOPATH/go/bin"
		# export PATH="$PATH:/usr/local/go/bin"


		# for flutter
		export PATH="$PATH:$HOME/flutter/bin"
		export PATH="$PATH:$HOME/flutter/.pub-cache/bin"

		# homebrewをhomedirにinstallして、opensslを使うための設定
		export PATH="$HOME/.homebrew/opt/openssl/bin:$PATH"
    ;;


		# for linux
  	linux*)
    	# ここに Linux 向けの設定
    ;;
esac

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
#
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
	alias gfro='git fetch remote origin'
	alias gcl='git clone'
	alias gpl='git pull'

	##push
	alias gps='git push'
	alias gpsf='git push --force'
	alias gpsa='git push --all'

	##rebase
	alias gr='git rebase'


	## config
	alias glocalname='git config --local user.name'
	alias glocalemail='git config --local user.email'


# Vim
	alias v='vim'
	alias vi='vim'

# Docker
	alias d='docker'
	alias dc='docker-compose'
	alias dps='docker ps'
	alias dpsa='docker ps -a'
	alias dcps='docker-compose ps'
	alias dclg='docker-compose logs'
	alias dbash='(){ docker exec -it $1 bash}' # bash login
	alias dcbash='(){ dc exec $1 bash}'
	alias dexi='(){ docker exec -it  $1 $2}' # docker exec
	alias dex='(){ docker exec $1 $2}' # docker exec
	alias dstopa='docker stop $(docker ps -q)' # stop all
	alias drma='docker rm $(docker ps -aq)' # container remove all
	alias dps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Ports}}\t{{.Status}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Size}}"'
	alias dpsa='docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Ports}}\t{{.Status}}\t{{.CreatedAt}}\t{{.RunningFor}}\t{{.Size}} "'
	alias dlogsf='() {  docker --logs --tail 10 -f $1 }'

# another
	alias gulp='nocorrect gulp'
	# vueやnuxt使用時にひらくブラウザ
  alias chromedev='open /Applications/Google\ Chrome\ Canary.app/ --args --disable-web-security --user-data-dir'
	# python + selenium + chrome + docker でのVNCウィンドウを開くよう
	alias opvnc='open vnc://localhost:5900'
	alias lzd='lazydocker'
	# shell relogin
	alias relogin='exec $SHELL -l'
	alias history='history -Di'
