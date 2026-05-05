---
name: pr-summary
description: 現在のブランチと比較ブランチ（develop / master / main）の差分から、日本語MarkdownのPR概要を作成して提示する。リポジトリの PULL_REQUEST_TEMPLATE.md があれば踏襲する。`gh pr create` までは行わず、本文の提示のみ。トリガー例「/pr-summary」「PR概要をまとめて」「このブランチとdevelopの差分でPR概要を」「マークダウン形式で」
---

# pr-summary

現在のブランチに含まれる変更（=PR対象の差分）から、**日本語MarkdownのPR概要**を作成して提示する。
**`gh pr create` / `gh pr edit` は実行しない**（本文の提示のみ。コミット・プッシュも行わない）。

## 引数（任意）

- **比較ブランチ** (`vs develop` / `develop` / `main`)
- **issue番号 / リンク** (`#339`, `https://github.com/.../issues/339`) — 関連 issue として末尾に記載
- **詳細度** (`short` / `detailed`) — 既定は `detailed`
- 出力先パスが指定された場合のみ、**確認のうえ**ファイルとして保存する（既定は提示のみ）

## 動作手順

### 1. 文脈を集める（並列で実行）

- `git rev-parse --abbrev-ref HEAD` で現ブランチ
- `git branch -a` から比較対象を決める。リポジトリの慣習に合わせる：
  - the-terminal.jp / zax 系 → `develop`
  - blanciris / weightly 系 → `main` または `master`
  - 不明なときはユーザーに確認
- `git merge-base <比較> HEAD` でマージベースを取得し、以下を読む:
  - `git diff <merge-base>...HEAD --stat`
  - `git log <merge-base>..HEAD --pretty=format:'%h %s%n%b%n---'`
  - 影響の大きい領域は `git diff <merge-base>...HEAD -- <パス>` で実コードを確認
- リポジトリに **`PULL_REQUEST_TEMPLATE.md` があれば必ず読む**（`.github/`、`docs/`、ルート）。その章立てに合わせる
- 同 issue の `.local/issues/<番号>/` に `research.md` / `plan.md` があれば必ず読む（背景は基本そこにある）

### 2. 構成（既定の章立て）

PR テンプレートが無い場合は以下を既定とする。**該当なしの章は省略**。

```markdown
## 背景
（なぜこの変更が必要か。元 issue のリンクがあれば末尾に。1〜2 段落）

## 変更内容
**機能/領域A**
- 何をどう変えたか（箇条書き、振る舞いベース）
- ...

**機能/領域B**
- ...

## 改善効果（パフォーマンス改善・バグ修正の影響範囲などがある場合）
| 指標 / API | 修正前 | 修正後 |
|---|---|---|
| ... | ... | ... |

## マイグレーション / 互換性（DB変更や破壊的変更がある場合）
- 必要な手順
- 後方互換の有無

## 動作確認 / テスト
- 追加・更新したテスト（`xxxTest.java` など）
- 手動確認した観点（できれば QA チェックリストへのリンク）

## 変更ファイル
- `path/to/file.ts` — 役割（一行）
- ...

## 関連
- Issue: #NNN
- 関連 PR: #MMM
```

PR テンプレートがある場合はそれを優先し、その見出しに沿って中身を書く（章を勝手に増やさない）。

### 3. 書き方の原則

- **why を最初に**。what は diff から読めるので、動機・トレードオフ・背景を背景に集約する
- 箇条書きは **振る舞いベース**（×「foo.ts を変更」 ○「展示会フィルタAPIで N+1 を解消」）
- 数字・効果が出せるものは表で（クエリ削減、レイテンシ、メモリ等）
- ファイル一覧は **多すぎる場合のみ**「主要ファイルのみ」と明記して間引く（10件超が目安）
- 詳細度 `short` のときは「## 背景」「## 変更内容（箇条書きのみ）」「## 関連」の3章だけにする

### 4. 提示する

- 出来上がった PR 概要を **コードフェンスで囲んだ Markdown ブロック**として一括提示する（そのまま GitHub に貼れる形）
- 直前に 1〜2 行で「比較ブランチ」「対象コミット数」「主要な変更領域」を要約する
- 不確実な点（背景の推測、影響範囲の不明点）は本文中に「**要確認**」マークで残し、提示後に箇条書きで質問を添える

### 5. ファイル保存（明示指示があった場合のみ）

- ユーザーが「`.local/issues/<NNN>/pr.md` に保存して」のように指示した場合のみファイルへ保存する
- 既存ファイルがあれば必ず読んでから上書きの可否を確認する

## やらないこと

- `gh pr create` / `gh pr edit` の実行（あくまで本文の提示）
- `git add` / `git commit` / `git push`
- diff から読み取れない仕様の創作。背景が読み切れない場合は **要確認** で残す
- PR テンプレートを無視した独自構成（テンプレートがあれば必ず踏襲）
- ファイル一覧の網羅にこだわって本質から外れた情報を膨らませること

## 出力例（テンプレ無しのケース）

````markdown
## 背景

`/api/brand/sales_report/category` と `/api/brand/sales_report/summary` で N+1 クエリが
発生しており、商品数が増えるとレスポンスが劣化する問題があった。

## 変更内容

**CategorySummary（`/sales_report/category`）**
- アイテムごとの OrderQuantity 取得（N クエリ）→ IN 句で一括取得（1クエリ）
- 中間リスト保持を廃止し one-pass 集計に変更

**Summary（`/sales_report/summary`）**
- items 全件ロードを廃止し、SQL 集計（COUNT DISTINCT / GROUP BY）に置き換え

## 改善効果

| API | 修正前 | 修正後 |
|---|---|---|
| `/category` All | 1 + N + M | **3** |
| `/summary` | 1 + 2N + 2K | **2** |

## 変更ファイル

- `ItemService.java` — partial load 化 + 2メソッド追加
- `CategorySummary.java` — N+1 解消 + one-pass 集計
- `Summary.java` — SQL 集計に置き換え

## 関連
- Issue: #303
````
