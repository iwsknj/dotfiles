#!/usr/bin/env python3
"""unified diff を hunk 単位に分割し、ID (h001..) 付きの JSON で stdout に出力する。

usage: python3 split_diff.py review.patch > hunks.json

出力: {"meta": {files, hunks, additions, deletions}, "hunks": [{id, file, status, header, diff}]}
"""
import json
import sys


def main():
    with open(sys.argv[1], encoding="utf-8", errors="replace") as f:
        lines = f.read().splitlines()

    hunks = []
    files = set()
    additions = deletions = 0
    old_path = new_path = None
    cur = None

    def flush():
        nonlocal cur
        if cur is not None:
            cur["diff"] = "\n".join(cur["diff"])
            hunks.append(cur)
            cur = None

    for line in lines:
        if line.startswith("diff --git "):
            flush()
            old_path = new_path = None
        elif line.startswith("@@"):
            flush()
            path = new_path or old_path or "(unknown)"
            files.add(path)
            status = "deleted" if new_path is None else ("new" if old_path is None else "modified")
            cur = {
                "id": f"h{len(hunks) + 1:03d}",
                "file": path,
                "status": status,
                "header": line,
                "diff": [],
            }
        elif cur is not None:
            # hunk本体。"--- x" で始まる削除行などをファイルヘッダと誤認しないよう、
            # ファイルヘッダの解釈は cur が閉じている（diff --git 直後）ときだけ行う
            cur["diff"].append(line)
            if line.startswith("+"):
                additions += 1
            elif line.startswith("-"):
                deletions += 1
        elif line.startswith("--- "):
            p = line[4:].split("\t")[0]
            old_path = None if p == "/dev/null" else (p[2:] if p.startswith("a/") else p)
        elif line.startswith("+++ "):
            p = line[4:].split("\t")[0]
            new_path = None if p == "/dev/null" else (p[2:] if p.startswith("b/") else p)
    flush()

    out = {
        "meta": {
            "files": len(files),
            "hunks": len(hunks),
            "additions": additions,
            "deletions": deletions,
        },
        "hunks": hunks,
    }
    json.dump(out, sys.stdout, ensure_ascii=False, indent=1)


if __name__ == "__main__":
    main()
