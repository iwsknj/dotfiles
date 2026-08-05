---
name: claude-review
description: Claude Code CLI（別セッション）でコードレビュー、分析、コードベースへの質問を実行する。別セッションのClaudeを明示的に指名されたときだけ使う（単に「レビューして」は組み込みの /code-review の担当）。トリガー: "claude-review", "claudeでレビュー", "別セッションのclaudeで分析", "/claude-review"
allowed-tools: Bash(claude:*)
---

# Claude Review

`claude` CLI を非対話モードで実行し、別コンテキストの Claude にコードレビュー・分析をさせるスキル。現在のセッションの文脈に引きずられないセカンドオピニオンが得られる。

## 実行コマンド

```bash
claude -p "<request>" --model opus --effort high --tools "Read,Grep,Glob"
```

**プロンプトは必ずオプションより前に置く**（`--tools` は可変長引数のため、後ろのプロンプトを吸い込んでエラーになる）。

## パラメータ

| パラメータ                 | 説明                                                           |
| -------------------------- | -------------------------------------------------------------- |
| `-p`                       | 非対話実行（結果を stdout に出力して終了）                     |
| `"<request>"`              | 依頼内容（日本語可）。オプションより前に置く                   |
| `--model opus`             | モデル指定（軽い確認なら `sonnet` でよい）                     |
| `--effort high`            | 推論の深さ（浅くてよければ `medium`）                          |
| `--tools "Read,Grep,Glob"` | 読み取り専用ツールのみ許可（安全な分析用・確認プロンプトなし） |

**対象ディレクトリ**: `claude` に `codex` の `--cd` 相当のオプションはないため、**対象プロジェクトのディレクトリで実行する**。

## 使用例

**注意**: 各例では末尾に「確認不要、具体的な提案まで出力」の指示を含めている。

### コードレビュー

```bash
claude -p "このプロジェクトのコードをレビューして、改善点を指摘してください" --model opus --effort high --tools "Read,Grep,Glob"
```

### 差分レビュー

```bash
claude -p "現在のブランチと main の差分をレビューして、バグ・考慮漏れを指摘してください。確認や質問は不要です。具体的な指摘まで自主的に出力してください。" --model opus --effort high --tools "Read,Grep,Glob,Bash" --allowedTools "Bash(git diff:*) Bash(git log:*)"
```

### アーキテクチャ分析

```bash
claude -p "このプロジェクトのアーキテクチャを分析して説明してください。確認や質問は不要です。改善提案まで自主的に出力してください。" --model opus --effort high --tools "Read,Grep,Glob"
```

### リファクタリング提案

```bash
claude -p "技術的負債を特定し、リファクタリング計画を提案してください。確認や質問は不要です。具体的なコード例まで自主的に出力してください。" --model opus --effort high --tools "Read,Grep,Glob"
```

### バグ調査

```bash
claude -p "認証処理でエラーが発生する原因を調査してください" --model opus --effort high --tools "Read,Grep,Glob"
```

## 実行手順

1. ユーザーから依頼内容を受け取る
2. 対象プロジェクトのディレクトリを特定し、そこで実行する
3. 上記コマンド形式で実行する
4. 結果をユーザーに報告する（レポートをファイルに残す場合は `> <出力先>/review.md` でリダイレクトする）

## 注意事項

- SessionStart フックの指示が出力に混ざる場合は `--setting-sources user,project` を追加してローカル設定を読ませない
