---
name: claude-research
description: Claude Code CLI（別セッション）でコードベースを深く読み込み、実装前に research.md に学び・前提・落とし穴を整理する。新機能/改修の最初に使う。使用場面: (1) タスク着手時。トリガー: "claude-research", "claudeでリサーチ"
allowed-tools: Bash(claude:*)
---

# Claude Deep Research

`claude` CLI を非対話モードで実行し、別コンテキストの Claude にコードベースを深く読み込ませて、実装前に `research.md` に学び・前提・落とし穴を整理させるスキル。

## 実行コマンド

```bash
claude -p "<request>" --model opus --effort high --tools "Read,Grep,Glob" > <出力先>/research.md
```

`--tools "Read,Grep,Glob"` のため Claude 自身はファイルを書き込めない。`research.md` は stdout のリダイレクトで生成する。

**プロンプトは必ずオプションより前に置く**（`--tools` は可変長引数のため、後ろのプロンプトを吸い込んでエラーになる）。

## パラメータ

| パラメータ                 | 説明                                                           |
| -------------------------- | -------------------------------------------------------------- |
| `-p`                       | 非対話実行（結果を stdout に出力して終了）                     |
| `"<request>"`              | 依頼内容（日本語可）。オプションより前に置く                   |
| `--model opus`             | モデル指定（軽い調査なら `sonnet` でよい）                     |
| `--effort high`            | 推論の深さ（浅くてよければ `medium`）                          |
| `--tools "Read,Grep,Glob"` | 読み取り専用ツールのみ許可（安全な分析用・確認プロンプトなし） |
| `> <file>`                 | 最終メッセージの書き出し先（= `research.md` の生成先）          |

**対象ディレクトリ**: `claude` に `codex` の `--cd` 相当のオプションはないため、**対象プロジェクトのディレクトリで実行する**（他ディレクトリも読ませたい場合は `--add-dir <dir>` を追加）。

## 使用例

**注意**: 各例では末尾に「確認不要、学び・前提・落とし穴を整理したMarkdownを出力」の指示を含めている。

### 実装前の現状把握

```bash
claude -p "<機能名>を追加する前提で、関連する既存実装・データフロー・呼び出し経路を調査してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。" --model opus --effort high --tools "Read,Grep,Glob" > <出力先>/research.md
```

### 影響範囲の調査

```bash
claude -p "<変更内容>を行った場合に影響を受ける箇所（呼び出し元・DBスキーマ・バッチ・テスト）を洗い出してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。" --model opus --effort high --tools "Read,Grep,Glob" > <出力先>/research.md
```

### 既存パターンの調査

```bash
claude -p "<類似機能>がこのコードベースでどう実装されているかを調査し、新機能で踏襲すべきパターンと避けるべき点を整理してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。" --model opus --effort high --tools "Read,Grep,Glob" > <出力先>/research.md
```

### 制約・落とし穴の調査

```bash
claude -p "<対象領域>の実装に着手する前に知っておくべき制約・暗黙の前提・既存のワークアラウンドを調査してください。確認や質問は不要です。学び・前提・落とし穴を整理したMarkdownを出力してください。" --model opus --effort high --tools "Read,Grep,Glob" > <出力先>/research.md
```

## 実行手順

1. ユーザーから依頼内容を受け取る
2. 対象プロジェクトのディレクトリを特定し、そこで実行する
3. タスク番号 or タスク名のディレクトリ（例: `.local/issues/<番号>/`）を `mkdir -p` で作成し、リダイレクト先に `research.md` を指定して上記コマンドを実行する
4. 生成された `research.md` を確認し、要点をユーザーに報告する

## 注意事項

- git 履歴も調査させたい場合は `--tools "Read,Grep,Glob,Bash" --allowedTools "Bash(git log:*) Bash(git diff:*)"` を追加する
- `-p` モードでは権限プロンプトは自動的に拒否されるため、許可していないツールの使用は静かに失敗する
- SessionStart フックの指示が出力に混ざる場合は `--setting-sources user,project` を追加してローカル設定を読ませない
