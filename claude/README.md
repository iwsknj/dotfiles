Claude codeのグローバル設定ファイル置き場

## ファイル構成

| ファイル | シンボリックリンク先 |
|---|---|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` → `~/AGENTS.md` |
| `settings.json` | `~/.claude/settings.json` |
| `skills/` | `~/.claude/skills/` |

## シンボリックリンクの構造

```
~/dotfiles/claude/CLAUDE.md  ←（実体）
        ↑
~/.claude/CLAUDE.md
        ↑
~/AGENTS.md
```

## セットアップ

`link.sh` を実行するか、手動で以下を実行：

```bash
ln -sfv ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfv ~/.claude/CLAUDE.md ~/AGENTS.md
ln -sfv ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sfv ~/dotfiles/claude/skills ~/.claude/skills
```
