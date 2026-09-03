#!/bin/sh
# PreToolUse hook: 機密ファイルへの直接アクセスを承認プロンプトなしで拒否する。
# 対象: Read/Edit/Write/NotebookEdit/Grep の file_path/path、Bash の command 文字列。
# .env.example のようなサンプルは許可。ディレクトリ再帰 (grep -r .) は対象外。
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
input=$(cat)
tool=$(printf '%s' "$input" | jq -r '.tool_name // ""')
case "$tool" in
  Bash) target=$(printf '%s' "$input" | jq -r '.tool_input.command // ""') ;;
  *)    target=$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.path // .tool_input.notebook_path // ""') ;;
esac
[ -n "$target" ] || exit 0

pre='(^|[][ /"'"'"'=:(,])'
name='(\.env(\.[A-Za-z0-9_.-]+)?|[A-Za-z0-9_.-]*\.pem|master\.key|\.npmrc|\.netrc|id_rsa|id_ed25519|id_ecdsa|id_dsa|\.ssh/[A-Za-z0-9_.-]*(id|key)[A-Za-z0-9_.-]*|terraform\.tfstate(\.backup)?|\.aws/credentials|secrets/[A-Za-z0-9_./-]+)'
post='([][ "'"'"'):;|&>,]|$)'

hit=$(printf '%s\n' "$target" | grep -oE "$pre$name$post" | grep -vE 'example|sample|template|dist|\.pub([^A-Za-z0-9]|$)' | head -1 | tr -d '[:space:]"'"'"'=:(),;|&>')
[ -n "$hit" ] || exit 0

printf '%s' "$hit" | jq -Rc '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:("機密ファイルのため拒否: " + .)}}'
