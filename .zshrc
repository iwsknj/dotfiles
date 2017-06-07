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
