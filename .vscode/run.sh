#!/usr/bin/env bash
set -e

FILE="$1"

if [ -z "$FILE" ]; then
    echo "Usage: run.sh <file>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "❌ Not a file: $FILE"
    exit 1
fi

EXT="${FILE##*.}"

case "$EXT" in
  c)
    ./.vscode/run_c.sh "$FILE"
    ;;
  cpp)

    ./.vscode/run_cpp.sh "$FILE"
    ;;
  py)
    echo "▶ Run Python"
    python3 "$FILE"
    ;;
  rs)
    ./.vscode/run_rs.sh "$FILE"
    ;;
  *)
    echo "❌ Unsupported file type: $EXT"
    exit 1
    ;;
esac
