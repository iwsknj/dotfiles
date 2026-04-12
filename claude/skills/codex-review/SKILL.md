---
name: codex-review
description: OpenAI Codex CLIを使用したコードレビュー、分析、コードベースへの質問を実行する。使用場面: (1) コードレビュー依頼時、(2) コードベース全体の分析、(3) 実装に関する質問、(4) バグの調査、(5) リファクタリング提案、(6) 解消が難しい問題の調査。トリガー: "codex-review", "コードレビュー", "レビューして", "分析して", "/codex-review"
---

# Codex

Codex CLIを使用してコードレビュー・分析を実行するスキル。

## 実行コマンド

codex exec --full-auto --sandbox read-only --cd <project_directory> "<request>"

## パラメータ

| パラメータ            | 説明                                       |
| --------------------- | ------------------------------------------ |
| `--full-auto`         | 完全自動モードで実行                       |
| `--sandbox read-only` | 読み取り専用サンドボックス（安全な分析用） |
| `--cd <dir>`          | 対象プロジェクトのディレクトリ             |
| `"<request>"`         | 依頼内容（日本語可）                       |

## 使用例

**注意**: 各例では末尾に「確認不要、具体的な提案まで出力」の指示を含めている。

### コードレビュー

codex exec --full-auto --sandbox read-only --cd /path/to/project "このプロジェクトのコードをレビューして、改善点を指摘してください"

### アーキテクチャ分析

codex exec --full-auto --sandbox read-only --cd /path/to/project "このプロジェクトのアーキテクチャを分析して説明してください。確認や質問は不要です。改善提案まで自主的に出力してください。"

### リファクタリング提案

codex exec --full-auto --sandbox read-only --cd /path/to/project "技術的負債を特定し、リファクタリング計画を提案してください。確認や質問は不要です。具体的なコード例まで自主的に出力してください。"

### バグ調査

codex exec --full-auto --sandbox read-only --cd /path/to/project "認証処理でエラーが発生する原因を調査してください"

## 実行手順

1. ユーザーから依頼内容を受け取る
2. 対象プロジェクトのディレクトリを特定する
3. 上記コマンド形式でCodexを実行
4. 結果をユーザーに報告
