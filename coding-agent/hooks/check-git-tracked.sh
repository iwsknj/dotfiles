#!/bin/bash

JQ="/opt/homebrew/bin/jq"

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | "$JQ" -r '.tool_input.file_path // .tool_input.path // .tool_input.filePath // empty')
TOOL_NAME=$(echo "$INPUT" | "$JQ" -r '.tool_name // empty')
PATCH_COMMAND=$(echo "$INPUT" | "$JQ" -r '.tool_input.command // empty')

request_confirmation() {
  local reason="$1"

  if [[ "$TOOL_NAME" == "apply_patch" ]]; then
    "$JQ" -n --arg reason "$reason" \
      '{decision:"block",reason:$reason}'
  else
    "$JQ" -n --arg reason "$reason" \
      '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"ask",permissionDecisionReason:$reason}}'
  fi
}

check_file() {
  local file_path="$1"

  [[ -z "$file_path" ]] && return 0

  if [[ "$file_path" != /* ]]; then
    file_path="$(pwd)/$file_path"
  fi

  [[ ! -e "$file_path" ]] && return 0

  local repo_root
  repo_root=$(git -C "$(dirname "$file_path")" rev-parse --show-toplevel 2>/dev/null)

  if [[ -z "$repo_root" ]]; then
    request_confirmation "Gitリポジトリ外のファイルです"
    exit 0
  fi

  git -C "$repo_root" ls-files --error-unmatch "$file_path" &>/dev/null && return 0

  request_confirmation "Git管理外のファイルです"
  exit 0
}

if [[ "$TOOL_NAME" == "apply_patch" && -n "$PATCH_COMMAND" ]]; then
  while IFS= read -r file_path; do
    check_file "$file_path"
  done < <(echo "$PATCH_COMMAND" | sed -n -E 's/^\*\*\* (Update|Delete) File: (.*)$/\2/p')
  exit 0
fi

check_file "$FILE_PATH"
