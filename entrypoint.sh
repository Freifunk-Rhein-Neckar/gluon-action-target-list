#!/bin/bash

set -euxo pipefail

GLUON_PATH="$1"

ALLOWLIST="${ALLOWLIST:-}"
DENYLIST="${DENYLIST:-}"
BROKEN="${BROKEN:0}"

# Get List of available Targets
AVAILABLE_TARGETS_NEWLINE="$(make --no-print-directory -C "$GLUON_PATH" list-targets "BROKEN=${BROKEN}" "GLUON_SITEDIR=${GLUON_SITEDIR}")"

# Format Allow- and Denylist
TARGET_ALLOWLIST_NEWLINE="$(echo "$ALLOWLIST" | tr ' ' '\n')"
TARGET_DENYLIST_NEWLINE="$(echo "$DENYLIST" | tr ' ' '\n')"

# Return all available targets if no allowlist is set
OUTPUT_TARGETS="${AVAILABLE_TARGETS_NEWLINE}"

if [ -n "$ALLOWLIST" ]; then
    # Only return words present in both lists
    OUTPUT_TARGETS="$(echo -e "$AVAILABLE_TARGETS_NEWLINE\n$TARGET_ALLOWLIST_NEWLINE" | sort | uniq -d)"
fi

if [ -n "$DENYLIST" ]; then
    # Remove words present in denylist
    OUTPUT_TARGETS="$(echo -e "$OUTPUT_TARGETS\n$TARGET_DENYLIST_NEWLINE" | sort | uniq -u)"
fi

# Convert to JSON
OUTPUT_JSON="$(echo "$OUTPUT_TARGETS" | jq  --raw-input .  | jq --slurp . | jq -c .)"

echo "$OUTPUT_JSON"
