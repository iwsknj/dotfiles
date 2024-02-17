: "sshコマンド補完を~/.ssh/configから行う" && {
	function _ssh { compadd `fgrep 'Host ' ~/.ssh/*/config ~/.ssh/*/*/config | grep -v '*' | awk '{print $2}' | sort` }
}

[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.linux ] && source ~/.zshrc.linux

# zshプロンプト
eval "$(starship init zsh)"
eval "$(sheldon source)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
