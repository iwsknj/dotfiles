---
name: codex-research
description: OpenAI Codex CLIを使用しコードベースを深く読み込み、実装前に research.md に学び・前提・落とし穴を整理する。新機能/改修の最初に使う。使用場面: (1) タスク着手時。トリガー: "codex-research", "codexでリサーチ"
allowed-tools: Bash(codex:*)
---

# Codex Deep Research

Codex CLIを使用してコードベースを深く読み込み、実装前に research.md に学び・前提・落とし穴を整理するスキル。

## 実行コマンド

codex exec -c 'approval_policy="never"' --sandbox read-only --cd <project_directory> -o <出力先>/research.md "<request>"

`--sandbox read-only` のため Codex 自身はファイルを書き込めない。`research.md` は `-o`（最終メッセージのファイル書き出し）で生成する。

## パラメータ

| パラメータ            | 説明                                       |
| --------------------- | ------------------------------------------ |
| `-c 'approval_policy="never"'` | 確認プロンプトなしで非対話実行             |
| `--sandbox read-only` | 読み取り専用サンドボックス（安全な分析用） |
| `--cd <dir>`          | 対象プロジェクトのディレクトリ             |
| `-o <file>`           | Codex の最終メッセージを書き出すパス（= `research.md` の生成先） |
| `"<request>"`         | 依頼内容（日本語可）                       |

## 使用例

**注意**: 各例では末尾に「確認不要、学び・前提・落とし穴を整理したMarkdownを出力」の指示を含めている。

### 実装前の現状把握

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project -o <出力先>/research.md "<機能名>を追加する前提で、関連する既存実装・データフロー・呼び出し経路を調査してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。"

### 影響範囲の調査

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project -o <出力先>/research.md "<変更内容>を行った場合に影響を受ける箇所（呼び出し元・DBスキーマ・バッチ・テスト）を洗い出してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。"

### 既存パターンの調査

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project -o <出力先>/research.md "<類似機能>がこのコードベースでどう実装されているかを調査し、新機能で踏襲すべきパターンと避けるべき点を整理してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。"

### 制約・落とし穴の調査

codex exec -c 'approval_policy="never"' --sandbox read-only --cd /path/to/project -o <出力先>/research.md "<対象領域>の実装に着手する前に知っておくべき制約・暗黙の前提・既存のワークアラウンドを調査してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。"

## 実行手順

1. ユーザーから依頼内容を受け取る
2. 対象プロジェクトのディレクトリを特定する
3. タスク番号 or タスク名のディレクトリ（例: `.local/issues/<番号>/`）を出力先とし、`-o` に `research.md` のパスを指定して上記コマンドを実行する
4. 生成された `research.md` を確認し、要点をユーザーに報告する
