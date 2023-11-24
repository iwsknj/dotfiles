: "sshコマンド補完を~/.ssh/configから行う" && {
	function _ssh { compadd `fgrep 'Host ' ~/.ssh/*/config ~/.ssh/*/*/config | grep -v '*' | awk '{print $2}' | sort` }
}

# git（brew でインストールしたもの）のパスを通す
export PATH=/usr/local/bin/git:$PATH


# zshプロンプト
eval "$(starship init zsh)"
eval "$(sheldon source)"
