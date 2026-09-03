#!/bin/sh
# PreToolUse(Bash) hook: 依存パッケージの追加（npm install <pkg> など）は承認を求める。
# 素の npm install / pnpm install（lockfile からの復元）やフラグのみの実行は通す。
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
cmd=$(jq -r '.tool_input.command // ""')
re='(^|[;&|(] *)(npm +(install|i|add)|pnpm +(add|install)|yarn +add|bundle +add)( +-[^ ]+)* +(@?[A-Za-z]|\.\.?/)'
printf '%s\n' "$cmd" | grep -Eq "$re" || exit 0
printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"依存パッケージの追加"}}\n'
