---
name: ask-codex
description: Codex CLIにコーディング支援を依頼します。セカンドオピニオン、コード生成、デバッグ、コーディングタスクの委任に使用します。
allowed-tools: Bash(codex *)
---

<!-- reffer: https://qiita.com/hiropon122/items/c130168ca3fc0f1f6aaa -->

# Ask Codex

ローカルの `codex` CLIを実行してコーディング支援を取得します。
※ 他のcodex SKILLSを指定されている場合は使わない

**注意:** このスキルを使用するには、`codex` CLIがインストールされ、システムのPATHで利用可能である必要があります。

## クイックスタート

`codex exec`で単一のクエリを実行します:

```bash
codex exec "Your question or task here"
```

## よく使うオプション

| オプション    | 説明                                            |
| ------------- | ----------------------------------------------- |
| `-m MODEL`    | モデルを指定                                    |
| `-C DIR`      | 作業ディレクトリを設定                          |
| `--full-auto` | workspace-writeサンドボックスで自動実行を有効化 |

> すべての利用可能なオプションについては、`codex exec --help`を実行してください

## 使用例

**コーディングの質問をする:**

```bash
codex exec "How do I implement a binary search in Python?"
```

**特定のディレクトリのコードを分析する:**

```bash
codex exec -C /path/to/project "Explain the architecture of this codebase"
```

**特定のモデルを使用する:**

```bash
codex exec -m o4-mini "Write a function that validates email addresses"
```

**Codexに自動的に変更を加えさせる:**

```bash
codex exec --full-auto "Add error handling to all API endpoints"
```

## 注意事項

- Codexは`exec`サブコマンドで非対話的に実行されます
- デフォルトでは、出力はstdoutに送られ、承認なしではファイルは変更されません
- サンドボックスの制約内で自動実行するには`--full-auto`を使用してください
- `-C`が指定されない限り、コマンドは現在の作業ディレクトリを継承します
