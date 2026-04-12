---
name: gtd
description: |
  GTD（Getting Things Done）ワークフローをtd CLI（Todoist）を使って実践するためのスキル。
  Claudeがコーチ兼ドライバーとして会話を主導し、ユーザーのタスク管理を支援する。

  以下のトリガーで起動：
  - "/gtd", "/gtd capture", "/gtd clarify", "/gtd organize", "/gtd review", "/gtd today"
  - "GTDやりたい", "週次レビュー", "タスク整理", "頭の中を整理", "今日何をやるか決めたい"
  - "キャプチャ", "インボックス処理", "inbox整理"
---

# GTD with `td`

## 基本原則

ClaudeがGTDのコーチとして会話を**主導**する。ユーザーに質問し、`td`コマンドを実行し、次のアクションを提案する。受け身にならないこと。

## フェーズ一覧

引数なし（`/gtd`）の場合、まず現状を確認してから最適なフェーズを提案する：

```bash
td sync && td today
```

を実行してオーバービューを見せ、「何から始めますか？」と聞く。

## フェーズ別ワークフロー

### Capture（収集）`/gtd capture`

頭の中にあるものを全部Inboxへ吐き出す。

1. 「今気になっていること、やらなければいけないこと、アイデアを全部話してください」と促す
2. ユーザーが話したものをまとめて`td add`で次々追加する（詳細は後でいい、タイトルだけ）
3. 「他にありますか？」を繰り返す
4. 終了したら件数を報告し、Clarifyへ誘導する

```bash
td add "タスク名"
# プロジェクト未指定 → 自動でInboxへ入る
```

### Clarify（明確化）`/gtd clarify`

Inboxのタスクを1つずつ処理する。詳細な問いかけは [references/clarify.md](references/clarify.md) を参照。

1. Inboxを取得：`td list -p Inbox --all`
2. 1件ずつ処理（ClaudeがNext Actionを問いかける）
3. 判断に応じて整理：プロジェクト移動・ラベル付け・削除

### Organize（整理）`/gtd organize`

ClarifyでNext Actionが決まったタスクに、プロジェクト・期日・優先度・ラベルを正しく設定する。

1. 整理が必要なタスクを表示：`td list --no-due --all` および `td list -p Inbox --all`
2. 各タスクに対してClaudeが確認：「どのプロジェクト？」「いつまで？」「優先度は？」「コンテキストは？」
3. まとめて設定：

```bash
td edit <id> \
  -p "プロジェクト名" \
  -d "next monday" \
  -P 3 \
  --add-label @work
```

詳細は [references/organize.md](references/organize.md) を参照。

### Weekly Review（週次レビュー）`/gtd review`

毎週1回、システム全体を見直す。手順は [references/weekly-review.md](references/weekly-review.md) を参照。

### Today（今日の集中）`/gtd today`

1. 今日のタスクを表示：`td today`
2. 期限切れ確認：`td list --overdue`
3. 今日のMIT（Most Important Task）をClaudeが3つ選ぶよう提案
4. 不要なタスクを延期・削除する

## `td`コマンド早引き

```bash
td sync                              # 最新状態に同期
td today                             # 今日のタスク
td list -p Inbox --all               # Inbox全件
td list --overdue                    # 期限切れ
td list --filter "today & @work"     # フィルター組み合わせ
td list --no-due                     # 期日なしタスク
td add "タスク名"                     # 追加（Inbox）
td add "タスク名" -p PROJECT -d tomorrow -P 3
td done <id>                         # 完了
td edit <id> -d "next week" -p 仕事 -l @waiting
td delete <id>                       # 削除
td projects                          # プロジェクト一覧
td labels                            # ラベル一覧
```

## GTDラベル規約（推奨）

| ラベル | 意味 |
|--------|------|
| @waiting | 誰かを待っている |
| @someday | いつかやる |
| @ref | 参照用（行動不要） |
| @home / @work / @pc / @phone | コンテキスト |

## 注意事項

- タスクIDはテーブルの左端番号またはUUID（先頭7文字でも可）
- 自然言語の日付が使える：`today`, `tomorrow`, `next monday`, `in 3 days`
- フィルター構文：`&`（AND）`|`（OR）`!`（NOT）`()`（グループ）
