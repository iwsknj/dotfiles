# Weekly Review（週次レビュー）詳細手順

週に1回、GTDシステム全体を見直してリフレッシュする。所要時間: 30〜60分。

## ステップ1: 同期・準備

```bash
td sync
```

「今週のレビューを始めます。まず現状を確認します」と宣言してから開始。

## ステップ2: Inbox処理

Inboxをゼロにする（Clarifyフェーズを実行）。

```bash
td list -p Inbox --all
```

→ 1件ずつ処理。詳細は clarify.md を参照。

## ステップ3: 完了確認・振り返り

今週完了したタスクを確認して、達成を認識する。

```bash
# 今週完了したタスクはTodoist側で確認
# Claudeは「今週どんなことが進みましたか？」と聞く
```

## ステップ4: 期限切れ処理

```bash
td list --overdue --all
```

各期限切れタスクに対して：
- 今週やる → 期日を更新 `td edit <id> -d today`
- 来週以降 → 期日を更新 `td edit <id> -d "next monday"`
- もう不要 → 削除 `td delete <id>`

## ステップ5: 今週・来週のタスク確認

```bash
td list --filter "today | tomorrow" --all
td list --filter "next 7 days" --all
```

過負荷になっていないか確認する。多すぎる場合は：
- 不要なものを削除
- 延期できるものを延期
- 委任できるものに@waitingラベル

## ステップ6: プロジェクトレビュー

```bash
td projects
```

各プロジェクトを確認して：
- 止まっているプロジェクトはないか？
- 次のアクションが設定されているか？
- 完了したプロジェクトはないか？

Claudeは「このプロジェクト、今週何か進展がありましたか？」と聞く。

## ステップ7: Somedayリスト確認

```bash
td list --label someday --all
# または
td list -f "@someday" --all
```

- 今やるべきものはActiveリストへ移動
- 永久にやらないものは削除

## ステップ8: 来週の計画

```bash
td list --filter "next 7 days" --sort priority
```

Claudeが聞く：
- 「来週の一番重要なことは何ですか？」
- 「それを達成するために今週中にやっておくことはありますか？」

MITを3つ決めて、期日・優先度を設定する。

## レビュー完了

「週次レビュー完了です。Inboxは空になりました。来週のMITは[X, Y, Z]です」と報告する。
