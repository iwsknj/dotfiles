### zinit ###
# typeset -gAH ZINIT
# ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
# ZINIT[ZCOMPDUMP_PATH]="$XDG_STATE_HOME/zcompdump"
# source "${ZINIT[HOME_DIR]}/bin/zinit.zsh"
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" # TODO: 消して上の読み込みでできるようにする
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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
		export PATH="/Users/$USER/.homebrew/opt/php@7.3/bin:$PATH"
		export PATH="/Users/$USER/.homebrew/opt/php@7.3/sbin:$PATH"
		export PATH="/usr/local/opt/php@7.3/bin:$PATH"
		export PATH="/usr/local/opt/php@7.3/sbin:$PATH"

		#php composer path
		export PATH=$PATH:~/.composer/vendor/bin/


		#nvm （プロジェクトごとにバージョンを変えたい場合は.nvmrcにバージョンを書き nvm useをする
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

		#nodebrew
		export PATH=$HOME/.nodebrew/current/bin:$PATH

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
		export GOPATH=$HOME/go
		export PATH=$GOPATH/bin:$PATH

		export GOENV_ROOT=$HOME/.goenv
		export PATH=$GOENV_ROOT/bin:$PATH
		export PATH=$HOME/.goenv/bin:$PATH
		eval "$(goenv init -)"


		# for flutter
		export PATH="$PATH:$HOME/flutter/bin"
		export PATH="$PATH:$HOME/flutter/.pub-cache/bin"

		# homebrewをhomedirにinstallして、opensslを使うための設定
		export PATH="$HOME/.homebrew/opt/openssl/bin:$PATH"

		# mysql
		export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
    ;;


		# for linux
  	linux*)
    	# ここに Linux 向けの設定
    ;;
esac



# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust


# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k


# plugin & other setting
zinit wait lucid as null for \
    atinit'source "/Users/kenjiiwase/dotfiles/.zshrc.lazy"' \
    @'zdharma-continuum/null'
		# atinit'source "$ZDOTDIR/.zshrc.lazy"' \

