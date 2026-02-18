#!/bin/bash

# Check dependencies
if ! command -v jq > /dev/null
then
    echo "Dependency not found: jq. Please install with your package manager."
    exit 1
fi

STATE_FILE="$HOME/.config/krotate.rc"

# output display name
OUTPUT_DISP=$(kscreen-doctor --json | jq  -r '.outputs | map(select(.enabled == true)) | .[0] | .id')

# if empty file, create new
[[ ! -f "$STATE_FILE" ]] && echo "n" > "$STATE_FILE"

state=$(cat "$STATE_FILE")

if [[ "$state" == "n" ]]; then
	echo "l" > "$STATE_FILE"
	kscreen-doctor output."$OUTPUT_DISP".rotation.left
elif [[ "$state" == "l" ]]; then
	echo "i" > "$STATE_FILE"
	kscreen-doctor output."$OUTPUT_DISP".rotation.inverted
elif [[ "$state" == "i" ]]; then
	echo "r" > "$STATE_FILE"
	kscreen-doctor output."$OUTPUT_DISP".rotation.right
else
	echo "n" > "$STATE_FILE"
	kscreen-doctor output."$OUTPUT_DISP".rotation.normal
fi
