---
name: ask-claude
description: Claude Code CLI（別セッション）にコーディング支援を依頼します。セカンドオピニオン、コード生成、デバッグ、コーディングタスクの委任に使用します。トリガー: "ask-claude", "claudeに聞いて", "別セッションのclaudeに"
allowed-tools: Bash(claude:*)
---

# Ask Claude

ローカルの `claude` CLI を非対話モード（`-p` / `--print`）で実行し、**現在のセッションとは別コンテキストの Claude** に作業を委任する。
※ 他の claude SKILLS（`claude-research` / `claude-plan` / `claude-review`）を指定されている場合は使わない

**注意:** `claude` CLI がインストールされ、PATH で利用可能である必要がある。

## クイックスタート

`-p` で単一のクエリを実行する:

```bash
claude -p "Your question or task here"
```

**プロンプトはオプションより前に置く。** `--tools` / `--allowedTools` / `--add-dir` は可変長引数のため、後ろに置いたプロンプトを引数として吸い込んでしまう。

## よく使うオプション

| オプション                      | 説明                                                     |
| ------------------------------- | -------------------------------------------------------- |
| `--model <model>`               | モデルを指定（`opus` / `sonnet` / `fable` / `haiku`）     |
| `--effort <level>`              | 推論の深さ（`low` / `medium` / `high` / `xhigh` / `max`） |
| `--tools "Read,Grep,Glob"`      | 使用可能ツールを限定（読み取り専用にする場合）           |
| `--permission-mode acceptEdits` | 編集を確認なしで許可（書き込みを伴う委任時）             |
| `--add-dir <dir>`               | 追加でアクセスを許可するディレクトリ                     |
| `--output-format json`          | 結果を JSON で受け取る（`text` がデフォルト）            |
| `--max-budget-usd <amount>`     | 消費上限（`-p` 時のみ）                                  |

> すべての利用可能なオプションについては、`claude --help` を実行してください

## 使用例

**コーディングの質問をする:**

```bash
claude -p "How do I implement a binary search in Python?"
```

**コードベースを分析する（読み取り専用）:**

```bash
claude -p "このコードベースのアーキテクチャを説明してください" --tools "Read,Grep,Glob"
```

**Claude に自動的に変更を加えさせる:**

```bash
claude -p "全APIエンドポイントにエラーハンドリングを追加してください" --permission-mode acceptEdits
```

## 注意事項

- **プロンプトは必ずオプションより前**（可変長オプションが引数を吸い込み `Input must be provided...` エラーになる）
- `codex exec` の `-C` に相当するオプションはない。**対象プロジェクトのディレクトリで実行する**（他ディレクトリも読む必要があれば `--add-dir` を追加）
- 出力は stdout に出るため、ファイル化はリダイレクト（`> out.md`）で行う
- `-p` モードでは権限プロンプトは自動的に拒否される。書き込みを伴う場合は `--permission-mode acceptEdits` を明示する
- `--tools "Read,Grep,Glob"` だけを許可すれば、確認なしで安全に読み取り専用の分析ができる
- SessionStart フックの指示が回答に混ざる場合は `--setting-sources user,project` を追加してローカル設定を読ませない
