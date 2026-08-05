---
name: diff-review
description: 差分が大きいときに明示的に呼ぶ、解説つきHTMLレビュー画面の生成スキル。差分を意図ごとにグループ分けし、リスク順に並べ、各hunkに解説を付けた自己完結HTMLを `.local/reviews/` に出力する。忖度対策として「planを知らないブラインドレビュー→plan照合」の2段階でレビューし、画面上で指摘の採用/却下・コメント記入・フィードバックmarkdownのコピーができる。トリガー: "/diff-review", "解説つきレビュー", "レビュー画面を作って", "diff review"。単に「レビューして」は組み込みの /code-review の担当。
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git branch:*), Bash(git rev-parse:*), Bash(git merge-base:*), Bash(python3:*), Bash(open:*), Bash(ls:*), Read, Write, Grep, Glob, Task
---

# diff-review

大きい差分を、人間が短時間で判断できる**解説つきレビュー画面（自己完結HTML）**にまとめる。
画面上で人間が「グループ承認」「指摘の採用/却下」「コメント」を行い、最後に**フィードバックmarkdownをコピーして元の作業セッションへ渡す**ところまでが導線。指摘の修正自体はこのスキルでは行わない。

スキルのファイル: `~/.claude/skills/diff-review/`（以下 `<skill>`）

## 引数（任意）

- **差分範囲**: `unstaged` / `staged` / `vs develop` など。無指定なら working tree の変更（staged + unstaged）、それも無ければ現ブランチ vs ベースブランチ
- **planパス**: `.local/issues/<n>/plan.md` など。無指定なら `.local/issues/` 配下と会話コンテキストから探す。見つからなければ第2段は会話コンテキストとの照合のみ行い、レポートの plan 欄は null にする

## 手順

### 1. 差分の収集と hunk 分割

```bash
git diff > <scratch>/review.patch        # 範囲に応じて（vs branchなら merge-base 起点の三点diff）
python3 <skill>/scripts/split_diff.py <scratch>/review.patch > <scratch>/hunks.json
```

hunks.json には全 hunk に `h001..` のIDと統計（files/hunks/±行数）が付く。**以後、差分はこのファイルで読む**（グループ・解説・指摘はすべてこのIDで参照するため）。

### 2. 第1段: ブラインドレビュー（忖度対策の核）

plan や本セッションの文脈を持たないサブエージェント（Task / general-purpose）に hunks.json のパスだけを渡してレビューさせる。「planに則っているから良し」という判断を構造的に不可能にするのが目的。プロンプトに含めること:

- 差分だけを根拠にレビューする。周辺コードを読むのは可。ただし `.local/` 配下・plan.md・research.md・PR説明など**意図を説明するドキュメントは読まない**
- 差分から**意図がつかめない変更は、それ自体を「意図不明」として指摘**する（差分だけで意図が伝わらない＝説明かコードに問題がある）
- 最終出力は findings の JSON 配列のみ: `[{severity, title, location, hunkId, body, suggestion}]`（severity: `error`/`warn`/`info`）

### 3. 第2段: plan照合

本体が plan・会話コンテキストと照合して findings を確定する:

- 第1段の指摘のうち plan で意図されているものは、`planNote` に「plan上は意図的」と明記した上で、**実装として妥当かを独立に再判定**する。「planに則っている」だけを理由に指摘を落とさない（severity を下げる場合も planNote に理由を書く）
- plan との乖離・plan項目の実装漏れを新規指摘として追加（`stage: 2`）
- plan を読まないと分からない指摘はそのまま残す（`stage` で由来を区別: 1=ブラインド, 2=plan照合）

### 4. グループ分けと解説

- hunk を**意図の単位**でグループ化する（例: rename + 関連する import 修正 = 1グループ）。ファイル単位ではない
- 各グループに title / kind（refactor・feature・fix・test・docs・config 等）/ risk / intent（何をなぜ変えたか、影響範囲まで1〜3文）を付ける
- risk の基準: `high`（要注意）= 認証・課金・共通基盤などロジック変更で影響が広い / `mid`（注意）= 挙動が変わりうるリファクタや広範囲の機械的変更 / `low`（低リスク）= docs・テスト・機械的変更
- **groups 配列はリスク高→低の順に並べる**（画面はこの順で表示される。ファイル順にしない）
- 各 hunk に1〜3行の解説（note）を付ける。意図不明・改善余地がある hunk は `flag: "warn"`（画面で「要改善」マーク）にし、対応する finding も登録する

### 5. annotations.json を書いて HTML 生成

下記スキーマで `<scratch>/annotations.json` を書き、ビルドする。**全 hunk をいずれかのグループに割り当てる**（漏れは build_report.py が警告し「未分類」グループに落ちる。警告が出たら割り当てを直す）。

```bash
python3 <skill>/scripts/build_report.py <skill>/assets/template.html \
  <scratch>/hunks.json <scratch>/annotations.json \
  <repo-root>/.local/reviews/<YYYYMMDD-HHmm>-<branch等のslug>.html
open <出力パス>
```

### 6. 提示

- 出力パスと、グループ構成（リスク順の一覧）、指摘件数（severity別・stage別）を要約して伝える
- 画面の使い方を一言添える: グループを承認 → 指摘を採用/却下・コメント → 「フィードバックを生成」→ コピーして元の作業セッションに貼り付け

## annotations.json スキーマ

```json
{
  "title": "app/system URL整理の未ステージ差分レビュー",
  "source": "git diff (unstaged)",
  "plan": ".local/issues/339/plan.md",
  "groups": [
    {
      "title": "URL・ホスト判定の共通基盤",
      "kind": "refactor",
      "risk": "high",
      "intent": "deployment modeごとのURL生成とhost判定を一か所に集約し、legacy-pathとsubdomainを安全に切り替える。影響範囲は広め。",
      "hunks": ["h079", "h080"],
      "notes": {
        "h079": { "text": "vitestのmockを共通configに差し替え。テストの前提が変わる点に注意。", "flag": "warn" }
      }
    }
  ],
  "findings": [
    {
      "severity": "warn",
      "stage": 1,
      "title": "省略可能な別フラグが context-only 処理の抜けを隠す",
      "location": "apps/web/src/.../ai-route-message-utils.ts 新L109〜",
      "hunkId": "h010",
      "body": "指摘の本文。何がどう問題か。",
      "suggestion": "isContextOnly を必須引数にし、受け渡しテストも追加する。",
      "planNote": "plan上は意図的な変更だが、実装として改善を求める"
    }
  ]
}
```

- `plan` 無しは `null`。`hunkId` はグループ横断の指摘（plan乖離など）なら `null` 可
- `notes` は文字列だけでも可（`"h079": "解説文"`）。`flag` は `"warn"` のときだけ意味を持つ
- グループの意図（`groupIntent`）は省略してよい（画面側が所属グループの intent を自動表示する）

## やらないこと

- 指摘の修正実施（フィードバックは元の作業セッションに渡して対応させる）
- ステージ・コミット・プッシュ
- diff から読み取れない意図の創作。分からないものは「要改善」として残すのがこのスキルの役目
