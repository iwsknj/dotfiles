# vimのkeybindにする
bindkey -v

: "sshコマンド補完を~/.ssh/configから行う" && {
	function _ssh { compadd `fgrep 'Host ' ~/.ssh/*/config ~/.ssh/*/*/config | grep -v '*' | awk '{print $2}' | sort` }
}

# シンボリックリンクで貼ることで意図的に読み込みを分けている
[ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
[ -f ~/.zshrc.linux ] && source ~/.zshrc.linux

# zshプロンプト
eval "$(starship init zsh)"
eval "$(sheldon source)"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ~/dotfiles/zsh ディレクトリ内の *.zsh ファイルを読み込む
for file in ~/dotfiles/zsh/*.zsh; do
    source $file
done

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kenj/Desktop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kenj/Desktop/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kenj/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kenj/Desktop/google-cloud-sdk/completion.zsh.inc'; fi
