#!/bin/sh
# 0 始まりのキー割り当て用ヘルパー。
#   goto.sh space <n>   n 番目 (1 始まり) の Space をフォーカス
#   goto.sh tab   <n>   フォーカス中の Space の n 番目 (1 始まり) の Tab をフォーカス
# キーバインド側で「押した数字 + 1」を渡すことで 0 始まりの操作感にしている。
set -e
kind="$1"
n="$2"

case "$kind" in
  space)
    # Pick by display position (sorted by number), not by the raw number field,
    # so gaps left by closed spaces don't break sequential jumps.
    id=$(herdr workspace list \
      | jq -r --argjson n "$n" \
          '[.result.workspaces[]] | sort_by(.number) | .[$n - 1].workspace_id // empty')
    [ -n "$id" ] && exec herdr workspace focus "$id"
    ;;
  tab)
    ws=$(herdr workspace list \
      | jq -r '.result.workspaces[] | select(.focused) | .workspace_id')
    [ -n "$ws" ] || exit 0
    id=$(herdr tab list \
      | jq -r --arg ws "$ws" --argjson n "$n" \
          '[.result.tabs[] | select(.workspace_id == $ws)] | sort_by(.number) | .[$n - 1].tab_id // empty')
    [ -n "$id" ] && exec herdr tab focus "$id"
    ;;
  *)
    echo "usage: goto.sh space|tab <n>" >&2
    exit 2
    ;;
esac
exit 0
