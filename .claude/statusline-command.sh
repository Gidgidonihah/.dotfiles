#!/bin/sh
# Claude Code status line - mirrors p10k style segments:
# hostname  cwd  git-branch | model  context-bar │ 5h bar/reset  7d % ... tokens (right-aligned)

input=$(cat)

host=$(hostname -s)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
short_dir=$(echo "$dir" | sed "s|^$HOME|~|")

model=$(echo "$input" | jq -r '.model.display_name // empty')

# Usage thresholds: <50 green, 50-75 yellow, 75-90 orange, >90 red (blinking)
pct_color() {
  awk -v p="$1" 'BEGIN {
    if (p < 50)       printf "\033[0;32m";
    else if (p < 75)  printf "\033[0;33m";
    else if (p <= 90) printf "\033[38;5;208m";
    else              printf "\033[5;31m";
  }'
}

# 10-cell block progress bar (floor to nearest cell)
mkbar() {
  awk -v p="$1" 'BEGIN {
    filled = int(p / 10);
    if (filled > 10) filled = 10;
    if (filled < 0) filled = 0;
    s = "";
    for (i = 0; i < filled; i++) s = s "█";
    for (i = filled; i < 10; i++) s = s "░";
    printf "%s", s;
  }'
}

# Seconds -> compact "2h1m" / "45m" / "<1m"
fmt_left() {
  s=$1
  [ "$s" -lt 0 ] && s=0
  h=$((s / 3600))
  m=$(((s % 3600) / 60))
  if [ "$h" -gt 0 ]; then
    printf '%dh%dm' "$h" "$m"
  elif [ "$m" -gt 0 ]; then
    printf '%dm' "$m"
  else
    printf '<1m'
  fi
}

reset_dim="\033[2m"
off="\033[0m"

# Context window usage
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_display=""
if [ -n "$used" ]; then
  ctx_display="$(pct_color "$used")$(mkbar "$used") $(printf '%.0f' "$used")%${off}"
fi

# Git branch (skip locks to avoid blocking)
branch=""
if [ -d "$dir/.git" ] || git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || GIT_OPTIONAL_LOCKS=0 git -C "$dir" rev-parse --short HEAD 2>/dev/null)
fi

now=$(date +%s)

# 5h session window: bar + % + time until reset
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
five_display=""
if [ -n "$five" ]; then
  five_display="$(pct_color "$five")5h: $(mkbar "$five") $(printf '%.0f' "$five")%${off}"
  if [ -n "$five_reset" ]; then
    five_display="$five_display ${reset_dim}($(fmt_left $((five_reset - now))))${off}"
  fi
fi

# 7d weekly window: percentage only, no bar
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_display=""
[ -n "$week" ] && week_display="$(pct_color "$week")7d: $(printf '%.0f' "$week")%${off}"

# Build the left-hand segment
left=$(printf "\033[0;32m%s\033[0m \033[0;33m%s\033[0m" "$host" "$short_dir")
[ -n "$branch" ] && left="$left $(printf "\033[0;36m%s\033[0m" "$branch")"
[ -n "$model" ] && left="$left $(printf "| \033[0;35m%s\033[0m" "$model")"
[ -n "$ctx_display" ] && left="$left $(printf '%b' "$ctx_display")"
if [ -n "$five_display" ] || [ -n "$week_display" ]; then
  left="$left │"
  [ -n "$five_display" ] && left="$left $(printf '%b' "$five_display")"
  [ -n "$week_display" ] && left="$left $(printf '%b' "$week_display")"
fi

printf '%s' "$left"

printf '\n'
