#!/usr/bin/env bash
# Swaps the tmux status bar's background/foreground colors between day and
# night, and keeps the active-window highlight as the inverse of that.
# Runs as a side effect of the status-bar refresh (status-left),
# printing nothing itself.
DAY_BG="#cb9057"
DAY_FG="black"

hour=$(date +%H)
# Night window: 16:00–06:59
if [ "$hour" -ge 16 ] || [ "$hour" -lt 7 ]; then
  bar_bg="$DAY_FG"; bar_fg="$DAY_BG"
else
  bar_bg="$DAY_BG"; bar_fg="$DAY_FG"
fi

tmux set-option -g status-style "bg=${bar_bg},fg=${bar_fg}" 2>/dev/null
# Active window: inverse of the bar, so it stands out either way.
tmux set-option -g window-status-current-style "bg=${bar_fg},fg=${bar_bg}" 2>/dev/null
