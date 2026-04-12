# Organize（整理）詳細ワークフロー

ClarifyでNext Actionが決まったタスクを、正しい「場所」に配置する。

## 整理の4軸

各タスクに以下を設定する：

| 軸 | 設定内容 | tdオプション |
|----|---------|-------------|
| プロジェクト | 複数ステップの成果物に属する場合 | `-p "プロジェクト名"` |
| 期日 | いつやるか | `-d "next monday"` |
| 優先度 | p1（urgent）〜p4（normal） | `-P 3` |
| コンテキスト | どこで・何を使ってやるか | `--add-label @work` |

## リスト別の配置ルール

| リスト | 条件 | 設定 |
|--------|------|------|
| Next Actions | すぐできる・具体的なアクション | プロジェクト＋コンテキストラベル |
| Waiting For | 誰かの返答待ち | `@waiting` ＋ 委任先を説明に記入 |
| Someday/Maybe | いつかやりたい・今は不要 | `@someday`、期日なし |
| Calendar | 特定日時に必ず発生 | 期日を正確に設定、優先度p2以上 |

## Claudeが確認する質問

1. 「これはどのプロジェクト（複数ステップの成果）に関係しますか？」
2. 「いつまでにやる必要がありますか？今週？来週？期日なし？」
3. 「これはPC前でないとできませんか？外出中でもできますか？」
4. 「優先度は？他のタスクと比べて急ぎですか？」

## よくある整理パターン

```bash
# PC前でやるNext Action
td edit <id> -p "仕事" --add-label @pc -d "this week"

# 誰かを待っているタスク
td edit <id> --add-label @waiting -c "Aさんの返答待ち: 〇〇の件"

# いつかやりたいアイデア
td edit <id> --add-label @someday --no-due -P 1

# 今週中に必ずやること
td edit <id> -d "friday" -P 3

# プロジェクトの最初のNext Action
td edit <id> -p "プロジェクト名" -d "today" -P 3 --add-label @pc
```

## 整理後の確認

```bash
# プロジェクト別に整理されているか
td projects

# 今週のタスク一覧で過負荷でないか確認
td list --filter "next 7 days" --sort priority

# @waitingタスクの確認
td list --filter "@waiting"
```
