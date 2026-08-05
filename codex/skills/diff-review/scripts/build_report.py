#!/usr/bin/env python3
"""hunks.json + annotations.json を template.html に埋め込み、レビュー画面HTMLを出力する。

usage: python3 build_report.py template.html hunks.json annotations.json out.html

- annotations の groups[].hunks (ID配列) を hunk 実体に解決し、notes を各 hunk に付与する
- どのグループにも属さない hunk は「未分類」グループに集めて警告を出す
"""
import json
import pathlib
import sys
from datetime import datetime


def main():
    template_p, hunks_p, ann_p, out_p = map(pathlib.Path, sys.argv[1:5])
    hunks_data = json.loads(hunks_p.read_text())
    ann = json.loads(ann_p.read_text())

    hunk_by_id = {h["id"]: h for h in hunks_data["hunks"]}
    used = set()
    for g in ann.get("groups", []):
        notes = g.pop("notes", {})
        resolved = []
        for hid in g.get("hunks", []):
            h = hunk_by_id.get(hid)
            if h is None:
                print(f"warning: グループ '{g.get('title')}' が存在しないhunk {hid} を参照", file=sys.stderr)
                continue
            note = notes.get(hid)
            if isinstance(note, str):
                note = {"text": note}
            resolved.append(dict(h, note=note))
            used.add(hid)
        g["hunks"] = resolved

    leftover = [h for h in hunks_data["hunks"] if h["id"] not in used]
    if leftover:
        print(f"warning: {len(leftover)}件のhunkが未分類（グループ割り当て漏れ）: "
              + " ".join(h["id"] for h in leftover), file=sys.stderr)
        ann.setdefault("groups", []).append({
            "title": "未分類",
            "kind": "other",
            "risk": "low",
            "intent": "どのグループにも割り当てられなかったhunk。割り当て漏れなので本来はゼロにする。",
            "hunks": [dict(h, note=None) for h in leftover],
        })

    for f in ann.get("findings", []):
        if f.get("hunkId") and f["hunkId"] not in hunk_by_id:
            print(f"warning: 指摘 '{f.get('title')}' が存在しないhunk {f['hunkId']} を参照", file=sys.stderr)

    meta = dict(hunks_data["meta"], generatedAt=datetime.now().strftime("%Y-%m-%d %H:%M"))
    data = {"meta": meta, **ann}
    payload = json.dumps(data, ensure_ascii=False).replace("</", "<\\/")

    html = template_p.read_text()
    if "__REVIEW_DATA__" not in html:
        sys.exit("error: template に __REVIEW_DATA__ プレースホルダがありません")
    out_p.parent.mkdir(parents=True, exist_ok=True)
    out_p.write_text(html.replace("__REVIEW_DATA__", payload, 1))
    print(out_p)


if __name__ == "__main__":
    main()
