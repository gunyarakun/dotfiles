#!/usr/bin/env bash
# Claude Code notification hook: macOS notifications via terminal-notifier.
# Wired into Stop and Notification events in ~/.claude/settings.json.

set -u

NOTIFIER=${TERMINAL_NOTIFIER:-/opt/homebrew/bin/terminal-notifier}
if [ ! -x "$NOTIFIER" ]; then
  NOTIFIER=$(command -v terminal-notifier || true)
fi
[ -z "${NOTIFIER:-}" ] && exit 0

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // ""')
event=$(printf '%s' "$input" | jq -r '.hook_event_name // ""')
message=$(printf '%s' "$input" | jq -r '.message // ""')
project=$(basename "${cwd:-$PWD}")

case "$event" in
  Stop)
    title="タスク完了"
    sound="Glass"
    body=${message:-Claude Code が応答を終えました}
    ;;
  Notification)
    case "$message" in
      *permission*|*Permission*|*許可*)
        title="許可待ち"
        sound="Ping"
        ;;
      *waiting*|*idle*|*input*|*待*)
        title="入力待ち"
        sound="Purr"
        ;;
      *)
        title="通知"
        sound="Pop"
        ;;
    esac
    body=${message:-Claude Code からの通知}
    ;;
  *)
    title="Claude Code"
    sound="Pop"
    body=${message:-$event}
    ;;
esac

"$NOTIFIER" \
  -title "$title" \
  -subtitle "$project" \
  -message "$body" \
  -sound "$sound" \
  -group "claude-code-$project" \
  >/dev/null 2>&1 || true

exit 0
