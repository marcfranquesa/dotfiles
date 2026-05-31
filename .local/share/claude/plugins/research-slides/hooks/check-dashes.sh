#!/bin/bash
# PostToolUse hook: catch en-dashes (--) and em-dashes (---) in slide .tex files.
# Fires after Write/Edit. Reads the file on disk and checks non-TikZ, non-comment text.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only check .tex files inside a slides/ directory
case "$FILE_PATH" in
  *slides/*.tex) ;;
  *) exit 0 ;;
esac

# File must exist
[ -f "$FILE_PATH" ] || exit 0

# Strip TikZ environments and comment lines, then look for --
MATCHES=$(sed '/\\begin{tikzpicture}/,/\\end{tikzpicture}/d' "$FILE_PATH" | \
  grep -v '^\s*%' | \
  grep -- '--' || true)

if [ -n "$MATCHES" ]; then
  jq -n '{
    "decision": "block",
    "reason": "STYLE VIOLATION: Found en-dash (--) or em-dash (---) in slide text. Replace with commas, semicolons, colons, parentheses, or write \"to\" for number ranges. Rewrite the file without any dashes."
  }'
fi

exit 0
