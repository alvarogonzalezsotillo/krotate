#!/bin/bash

# Check dependencies
if ! command -v jq > /dev/null
then
    echo "Dependency not found: jq. Please install with your package manager."
    exit 1
fi

# output display name
OUTPUT_DISP=$(kscreen-doctor --json | jq  -r '.outputs | map(select(.enabled == true)) | .[0] | .id')

# Rotation
ROTATION=$(kscreen-doctor --json | jq  -r '.outputs | map(select(.enabled == true)) | .[0] | .rotation')


if [[ "$ROTATION" == "1" ]]; then
	kscreen-doctor output."$OUTPUT_DISP".rotation.right
elif [[ "$ROTATION" == "8" ]]; then
	kscreen-doctor output."$OUTPUT_DISP".rotation.inverted
elif [[ "$ROTATION" == "4" ]]; then
	kscreen-doctor output."$OUTPUT_DISP".rotation.left
else
	kscreen-doctor output."$OUTPUT_DISP".rotation.normal
fi
