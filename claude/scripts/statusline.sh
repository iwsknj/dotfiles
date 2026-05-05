#!/usr/bin/env bash

# Claude Code Status Line Script
# 3-line display with model info, rate limit usage bars

input=$(cat)

# ── 1行目の情報 ──────────────────────────────────────────────

MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
USED_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | awk '{printf "%.0f", $1}')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')
TRANSCRIPT_PATH=$(echo "$input" | jq -r '.transcript_path // ""')

# トークン数をトランスクリプトから取得
TOKEN_DISPLAY=""
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
  total_tokens=$(tail -n 100 "$TRANSCRIPT_PATH" 2>/dev/null |
    jq -s 'map(select(.type == "assistant" and .message.usage)) |
    last |
    .message.usage |
    (.input_tokens // 0) +
    (.output_tokens // 0) +
    (.cache_creation_input_tokens // 0) +
    (.cache_read_input_tokens // 0)' 2>/dev/null)
  total_tokens=${total_tokens:-0}
  if [ "$total_tokens" -ge 1000 ]; then
    TOKEN_DISPLAY=$(printf " (%.1fK)" "$(echo "scale=1; $total_tokens/1000" | bc)")
  elif [ "$total_tokens" -gt 0 ]; then
    TOKEN_DISPLAY=" (${total_tokens})"
  fi
fi

# git の変更行数
DIFF_DISPLAY=""
if git -C "$CURRENT_DIR" rev-parse --git-dir &>/dev/null 2>&1; then
  DIFF_STATS=$(git -C "$CURRENT_DIR" diff --shortstat HEAD 2>/dev/null)
  if [ -n "$DIFF_STATS" ]; then
    ADDED=$(echo "$DIFF_STATS" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo "0")
    DELETED=$(echo "$DIFF_STATS" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo "0")
    [ -z "$ADDED" ] && ADDED=0
    [ -z "$DELETED" ] && DELETED=0
    DIFF_DISPLAY=" +${ADDED}/-${DELETED}"
  fi
fi

# git ブランチ
BRANCH_DISPLAY=""
if git -C "$CURRENT_DIR" rev-parse --git-dir &>/dev/null 2>&1; then
  BRANCH=$(git -C "$CURRENT_DIR" branch --show-current 2>/dev/null)
  if [ -z "$BRANCH" ]; then
    BRANCH=$(git -C "$CURRENT_DIR" rev-parse --short HEAD 2>/dev/null)
    [ -n "$BRANCH" ] && BRANCH="HEAD ($BRANCH)"
  fi
  [ -n "$BRANCH" ] && BRANCH_DISPLAY=" $BRANCH"
fi

# カラーコード (ANSI 256色 or truecolor)
color_green="\033[38;2;151;201;195m"
color_yellow="\033[38;2;229;192;123m"
color_red="\033[38;2;224;108;117m"
color_gray="\033[38;2;74;88;92m"
color_reset="\033[0m"

pick_color() {
  local pct=$1
  if [ "$pct" -ge 80 ]; then
    printf "%s" "$color_red"
  elif [ "$pct" -ge 50 ]; then
    printf "%s" "$color_yellow"
  else
    printf "%s" "$color_green"
  fi
}

SEP="${color_gray} │ ${color_reset}"

CTX_COLOR=$(pick_color "$USED_PCT")
LINE1=$(printf "%s🤖 %s%s${SEP}📊 %s%s%%%s%s" \
  "" \
  "$MODEL_DISPLAY" \
  "" \
  "$CTX_COLOR" "$USED_PCT" "$color_reset" "$TOKEN_DISPLAY")

if [ -n "$DIFF_DISPLAY" ]; then
  LINE1="${LINE1}${SEP}✏️ ${DIFF_DISPLAY}"
fi

if [ -n "$BRANCH_DISPLAY" ]; then
  LINE1="${LINE1}${SEP}🔀${BRANCH_DISPLAY}"
fi

DIR_NAME=$(basename "$CURRENT_DIR")
LINE1="${LINE1}${SEP}📁 ${DIR_NAME}"

# ── レートリミット情報の取得（キャッシュ付き） ─────────────────

CACHE_FILE="/tmp/claude-usage-cache.json"
CACHE_TTL=900
USAGE_JSON=""

now=$(date +%s)
CACHED_JSON=""
if [ -f "$CACHE_FILE" ]; then
  CACHED_JSON=$(cat "$CACHE_FILE")
  cache_ts=$(echo "$CACHED_JSON" | jq -r '.cached_at // 0' 2>/dev/null || echo 0)
  age=$((now - cache_ts))
  if [ "$age" -lt "$CACHE_TTL" ]; then
    USAGE_JSON="$CACHED_JSON"
  fi
fi

if [ -z "$USAGE_JSON" ]; then
  # macOSキーチェーンからOAuthトークンを取得
  TOKEN=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null | \
    python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('claudeAiOauth',{}).get('accessToken',''))" 2>/dev/null || true)

  if [ -n "$TOKEN" ]; then
    CC_VERSION=$(echo "$input" | jq -r '.version // "0.0.0"')
    # Haiku へのミニリクエストでレスポンスヘッダーからレート制限を取得
    headers=$(curl -sD- --max-time 8 -o /dev/null \
      -H "Authorization: Bearer ${TOKEN}" \
      -H "Content-Type: application/json" \
      -H "User-Agent: claude-code/${CC_VERSION}" \
      -H "anthropic-beta: oauth-2025-04-20" \
      -H "anthropic-version: 2023-06-01" \
      -d '{"model":"claude-haiku-4-5-20251001","max_tokens":1,"messages":[{"role":"user","content":"h"}]}' \
      "https://api.anthropic.com/v1/messages" 2>/dev/null || true)

    h5_util=$(echo "$headers" | grep -i 'anthropic-ratelimit-unified-5h-utilization' | tr -d '\r' | awk '{print $2}')
    h5_reset=$(echo "$headers" | grep -i 'anthropic-ratelimit-unified-5h-reset' | tr -d '\r' | awk '{print $2}')
    h7_util=$(echo "$headers" | grep -i 'anthropic-ratelimit-unified-7d-utilization' | tr -d '\r' | awk '{print $2}')
    h7_reset=$(echo "$headers" | grep -i 'anthropic-ratelimit-unified-7d-reset' | tr -d '\r' | awk '{print $2}')

    if [ -n "$h5_util" ]; then
      USAGE_JSON=$(jq -n \
        --arg h5u "$h5_util" --arg h5r "$h5_reset" \
        --arg h7u "$h7_util" --arg h7r "$h7_reset" \
        --argjson ts "$now" \
        '{five_hour_util: $h5u, five_hour_reset: $h5r, seven_day_util: $h7u, seven_day_reset: $h7r, cached_at: $ts}')
      echo "$USAGE_JSON" > "$CACHE_FILE" 2>/dev/null || true
    elif [ -n "$CACHED_JSON" ]; then
      USAGE_JSON="$CACHED_JSON"
    fi
  fi
fi

# ── プログレスバー生成関数 ──────────────────────────────────

make_bar() {
  local pct=$1
  local filled=$(( pct * 10 / 100 ))
  [ "$filled" -gt 10 ] && filled=10
  local empty=$((10 - filled))
  local bar=""
  local c
  c=$(pick_color "$pct")
  bar="${c}"
  for ((i=0; i<filled; i++)); do bar="${bar}▰"; done
  bar="${bar}${color_gray}"
  for ((i=0; i<empty; i++)); do bar="${bar}▱"; done
  bar="${bar}${color_reset}"
  printf "%s" "$bar"
}

# ── 2行目・3行目の生成 ─────────────────────────────────────

LINE2=""
LINE3=""

if [ -n "$USAGE_JSON" ] && echo "$USAGE_JSON" | jq -e '.five_hour_util' &>/dev/null 2>&1; then
  FIVE_UTIL=$(echo "$USAGE_JSON" | jq -r '.five_hour_util // 0' | awk '{printf "%.0f", $1 * 100}')
  SEVEN_UTIL=$(echo "$USAGE_JSON" | jq -r '.seven_day_util // 0' | awk '{printf "%.0f", $1 * 100}')

  # 5時間リセット時刻（epoch秒）
  FIVE_RESET_EPOCH=$(echo "$USAGE_JSON" | jq -r '.five_hour_reset // ""')
  if [ -n "$FIVE_RESET_EPOCH" ] && [ "$FIVE_RESET_EPOCH" != "null" ] && [ "$FIVE_RESET_EPOCH" != "0" ]; then
    FIVE_RESET_LOCAL=$(TZ="Asia/Tokyo" date -j -f "%s" "$FIVE_RESET_EPOCH" "+%-I%p" 2>/dev/null || \
      TZ="Asia/Tokyo" date -d "@${FIVE_RESET_EPOCH}" "+%-I%p" 2>/dev/null || echo "")
    [ -n "$FIVE_RESET_LOCAL" ] && FIVE_RESET_STR="Resets ${FIVE_RESET_LOCAL} (Asia/Tokyo)"
  fi

  # 7日間リセット時刻（epoch秒）
  SEVEN_RESET_EPOCH=$(echo "$USAGE_JSON" | jq -r '.seven_day_reset // ""')
  if [ -n "$SEVEN_RESET_EPOCH" ] && [ "$SEVEN_RESET_EPOCH" != "null" ] && [ "$SEVEN_RESET_EPOCH" != "0" ]; then
    SEVEN_RESET_LOCAL=$(TZ="Asia/Tokyo" date -j -f "%s" "$SEVEN_RESET_EPOCH" "+%b %-d at %-I%p" 2>/dev/null || \
      TZ="Asia/Tokyo" date -d "@${SEVEN_RESET_EPOCH}" "+%b %-d at %-I%p" 2>/dev/null || echo "")
    [ -n "$SEVEN_RESET_LOCAL" ] && SEVEN_RESET_STR="Resets ${SEVEN_RESET_LOCAL} (Asia/Tokyo)"
  fi

  FIVE_BAR=$(make_bar "$FIVE_UTIL")
  FIVE_COLOR=$(pick_color "$FIVE_UTIL")
  LINE2=$(printf "⏱ 5h  %s  %s%s%%%s  %s" \
    "$FIVE_BAR" \
    "$FIVE_COLOR" "$FIVE_UTIL" "$color_reset" \
    "${FIVE_RESET_STR:-}")

  SEVEN_BAR=$(make_bar "$SEVEN_UTIL")
  SEVEN_COLOR=$(pick_color "$SEVEN_UTIL")
  LINE3=$(printf "📅 7d  %s  %s%s%%%s  %s" \
    "$SEVEN_BAR" \
    "$SEVEN_COLOR" "$SEVEN_UTIL" "$color_reset" \
    "${SEVEN_RESET_STR:-}")
else
  LINE2="⏱ 5h  ${color_gray}(no data)${color_reset}"
  LINE3="📅 7d  ${color_gray}(no data)${color_reset}"
fi

# ── 出力 ───────────────────────────────────────────────────

printf "%b\n%b\n%b\n" "$LINE1" "$LINE2" "$LINE3"
