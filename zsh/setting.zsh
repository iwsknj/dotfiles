### 一般的な設定 ###
# refere to https://suin.io/568
setopt correct                        # 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt nobeep                         # ビープを鳴らさない
setopt no_tify                        # バックグラウンドジョブが終了したらすぐに知らせる。
unsetopt auto_menu                    # タブによるファイルの順番切り替えをしない
setopt auto_pushd                     # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_cd                        # ディレクトリ名を入力するだけでcdできるようにする
setopt interactive_comments           # コマンドラインでも # 以降をコメントと見なす

### ヒストリ関連の設定 ###
# refere to https://suin.io/568
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
setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_save_no_dups      # 履歴ファイルに書き出す際、新しいコマンドと重複する古いコマンドは切り捨てる

### 補完の設定 ###
autoload -U compinit && compinit      # 補完機能の強化
zstyle ':completion:*:default' menu select=1 # 補完候補をカーソル or タブで選択できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 小文字でも大文字ディレクトリ、ファイルを補完できるようにする
setopt auto_param_slash               # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs                      # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types                     # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu                      # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys                # カッコの対応などを自動的に補完
setopt interactive_comments           # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst              # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word               # 語の途中でもカーソル位置で補完
setopt always_last_prompt             # カーソル位置は保持したままファイル名一覧を順次その場で表示
