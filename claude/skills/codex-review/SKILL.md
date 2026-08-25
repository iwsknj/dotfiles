---
name: codex-review
description: OpenAI Codex CLIを使用したコードレビュー、分析、コードベースへの質問を実行する。Codexを明示的に指名されたときだけ使う（単に「レビューして」は組み込みの /code-review の担当）。トリガー: "codex-review", "codexでレビュー", "codexで分析", "/codex-review"
allowed-tools: Bash(codex:*)
---

# Codex

Codex CLIを使用してコードレビュー・分析を実行するスキル。

## 実行コマンド

codex exec -c 'approval_policy="never"' --sandbox read-only --cd <project_directory> "<request>" </dev/null

## パラメータ

| パラメータ            | 説明                                       |
| --------------------- | ------------------------------------------ |
| `-c 'approval_policy="never"'` | 確認プロンプトなしで非対話実行             |
| `--sandbox read-only` | 読み取り専用サンドボックス（安全な分析用） |
| `--cd <dir>`          | 対象プロジェクトのディレクトリ             |
| `"<request>"`         | 依頼内容（日本語可）                       |
| `</dev/null`          | stdin を閉じる。**必須**。省略すると stdin が開いたままの環境（Claude Code の Bash 等）で Codex が「Reading additional input from stdin...」のまま入力待ちでハングする（openai/codex#20919） |

## 使用例

**注意**: 各例では末尾に「確認不要、具体的な提案まで出力」の指示を含めている。

### コードレビュー

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project "このプロジェクトのコードをレビューして、改善点を指摘してください" </dev/null

### アーキテクチャ分析

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project "このプロジェクトのアーキテクチャを分析して説明してください。確認や質問は不要です。改善提案まで自主的に出力してください。" </dev/null

### リファクタリング提案

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project "技術的負債を特定し、リファクタリング計画を提案してください。確認や質問は不要です。具体的なコード例まで自主的に出力してください。" </dev/null

### バグ調査

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project "認証処理でエラーが発生する原因を調査してください" </dev/null

## 実行手順

1. ユーザーから依頼内容を受け取る
2. 対象プロジェクトのディレクトリを特定する
3. 上記コマンド形式でCodexを実行
4. 結果をユーザーに報告
