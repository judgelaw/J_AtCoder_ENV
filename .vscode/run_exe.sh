#!/usr/bin/env bash
set -e

FILE="$1"

if [ -z "$FILE" ]; then
    echo "❌ No file provided."
    exit 1
fi

EXT="${FILE##*.}"
WORKSPACE_DIR="$(pwd)"
OUTPUT="${WORKSPACE_DIR}/main.exe"

case "$EXT" in
    rs)
        # Rust
        echo "▶ コンパイル済みRustファイルの実行"
        echo "「Running \"target/release/main\"」 が表示されたら入力してください"

        mkdir -p "$WORKSPACE_DIR/src"
        cp "$FILE" "$WORKSPACE_DIR/src/main.rs"
        cargo run --release --offline
        ;;
    c|cpp)
        echo "▶ コンパイル済みexeファイルの実行"
        "$OUTPUT"
        ;;
    py)
        # Python
        echo "▶ Run Python"
        python3 "$FILE"
        ;;
    *)
        echo "❌ Unsupported file type: .$EXT"
        exit 1
        ;;
esac

echo "✅ Done"