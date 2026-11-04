#!/bin/sh
# 0 始まりで番号を振った Space 一覧を出し、押した数字の Space へ移動する。
# 組み込みの workspace_picker は番号の振り方を設定できないため、その代替。
printf '\n  Spaces\n\n'
# Number by display position (sorted by number) so the list stays 0..N even
# when closed spaces leave gaps in the raw number field.
herdr workspace list | jq -r '
  [.result.workspaces[]] | sort_by(.number) | to_entries[]
  | "  \(.key)  \(.value.label)\(if .value.focused then "  *" else "" end)"'
printf '\n  0-9 to switch, any other key to close: '

old=$(stty -g 2>/dev/null) || old=""
[ -n "$old" ] && stty raw -echo
key=$(dd bs=1 count=1 2>/dev/null)
[ -n "$old" ] && stty "$old"
printf '\n'

case "$key" in
  [0-9]) sh "$(dirname "$0")/goto.sh" space $((key + 1)) >/dev/null 2>&1 ;;
esac
