# historyをfzfを使って曖昧検索する
# reffer: https://mogulla3.tech/articles/2021-09-06-search-command-history-with-incremental-search/
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --exact --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
}

zle -N select-history       # ZLEのウィジェットとして関数を登録
bindkey '^R' select-history # `Ctrl+r` で登録したselect-historyウィジェットを呼び出す
