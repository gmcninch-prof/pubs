#!/usr/bin/env bash

# Usage: ./extract-abstracts.sh <abstract-dir> [output-file]
# Defaults to current directory and abstracts.txt

ABSTRACT_DIR="${1:-.}"
OUTPUT_FILE="${2:-abstracts.txt}"

> "$OUTPUT_FILE"

for f in "$ABSTRACT_DIR"/*.abstract; do
    [[ -f "$f" ]] || continue
    basename=$(basename "$f" .abstract)
    # Escape any double-quotes in the content

    content=$(python3 -c "
import sys
text = open('$f').read()
text = text.replace('\n\n', '\x00')  # protect paragraph breaks
text = text.replace('\n', ' ')       # collapse line wraps
text = text.replace('\x00', '\n\n')  # restore paragraph breaks
text = text.replace('\"', '\\\\\"')  # escape double quotes
print(text, end='')
")

    printf 'let %s = "%s"\n\n' "$basename" "$content" >> "$OUTPUT_FILE"
done

echo "Done. Output written to $OUTPUT_FILE"
