#!/usr/bin/env bash
# rofi + xclip clipboard history manager (X11)
#
# Usage:
#   clipboard.sh daemon            poll the X clipboard in the background
#   clipboard.sh menu              launch the rofi picker
#   clipboard.sh clear             wipe the history file
#   clipboard.sh print             dump the stored history

history_file="${XDG_CACHE_HOME:-$HOME/.cache}/rofi/clipboard-history"
max_entries=80
rofi_theme="$HOME/.config/rofi/clipboard.rasi"

normalize() {
	sed ':a;N;$!ba;s/\n/\\n/g'
}

restore() {
	sed 's/\\n/\n/g'
}

add() {
	local text="$1"
	[ -f "$history_file" ] || : > "$history_file"

	local entry
	entry="$(printf '%s' "$text" | normalize)"

	grep -qxF -- "$entry" "$history_file" && return

	printf '%s\n' "$entry" >> "$history_file"
	tail -n "$max_entries" "$history_file" > "$history_file.tmp"
	mv "$history_file.tmp" "$history_file"
}

daemon() {
	mkdir -p "$(dirname "$history_file")"
	: > "$history_file"

	local last=""
	while true; do
		local cur
		cur="$(xclip -o -selection clipboard 2>/dev/null || true)"
		if [ -n "$cur" ] && [ "$cur" != "$last" ]; then
			last="$cur"
			add "$cur"
		fi
		sleep 1
	done
}

menu() {
	[ -f "$history_file" ] || exit 0

	local pick
	pick="$(tail -n "$max_entries" "$history_file" | tac \
		| rofi -dmenu -theme "$rofi_theme" -p "" -mesg "clipboard history")"
	[ -n "$pick" ] || exit 0

	local text
	text="$(printf '%s' "$pick" | restore)"
	printf '%s' "$text" | xclip -selection clipboard
	printf '%s' "$text" | xclip -selection primary
}

case "${1:-menu}" in
	daemon) daemon ;;
	menu) menu ;;
	clear) rm -f "$history_file" ;;
	print) [ -f "$history_file" ] && tail -n "$max_entries" "$history_file" | tac ;;
	*) menu ;;
esac