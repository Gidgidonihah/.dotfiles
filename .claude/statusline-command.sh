#!/bin/sh
# Claude Code status line - mirrors p10k style segments:
# directory  git-branch  |  model  context%

input=$(cat)

host=$(hostname -s)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
short_dir=$(echo "$dir" | sed "s|^$HOME|~|")

model=$(echo "$input" | jq -r '.model.display_name // empty')

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  used_display=" ctx:$(printf '%.0f' "$used")%"
else
  used_display=""
fi

# Git branch (skip locks to avoid blocking)
branch=""
if [ -d "$dir/.git" ] || git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  [ -n "$branch" ] && branch=$(printf " \033[0;36m%s\033[0m" "$branch")
fi

printf "\033[0;32m%s\033[0m \033[0;33m%s\033[0m%s\033[0m" "$host" "$short_dir" "$branch"

if [ -n "$model" ]; then
  printf " \033[2m|\033[0m \033[0;35m%s\033[0m" "$model"
fi

if [ -n "$used_display" ]; then
  printf " \033[2m%s\033[0m" "$used_display"
fi

printf "\n"
