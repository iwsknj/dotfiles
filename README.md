# dotfiles

## how to set up

```bash
git clone git@github.com:iwsknj/dotfiles.git ~/dotfiles

# ツール一式（jq / node など。hook が jq に依存）
brew bundle --file ~/dotfiles/Brewfile

# Claude Code / Codex CLI を入れて一度起動し、~/.claude と ~/.codex を作っておく
npm i -g @anthropic-ai/claude-code @openai/codex

# シンボリックリンクを貼る
chmod +x ~/dotfiles/link.sh
~/dotfiles/link.sh
```

- `link.sh` 冒頭の espanso / Karabiner / Google日本語入力は Dropbox の同期が前提。未同期なら先に同期するかその部分をコメントアウトする
- `codex/config.toml` は `/Users/kenj/...` の絶対パスを含むため、ユーザー名が異なる環境では要修正

## after setup

write my email to ~/.gitconfig.local
