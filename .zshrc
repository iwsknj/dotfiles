: "sshコマンド補完を~/.ssh/configから行う" && {
	function _ssh { compadd `fgrep 'Host ' ~/.ssh/*/config ~/.ssh/*/*/config | grep -v '*' | awk '{print $2}' | sort` }
}

# git
export PATH=/usr/local/bin/git:$PATH
