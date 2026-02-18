#!/usr/bin/env bash
set -e

FILE="$1"
if [ -z "$FILE" ]; then
    echo "❌ No file provided."
    exit 1
fi

EXT="${FILE##*.}"
WORKSPACE_DIR="$(pwd)"

# 言語ごとにバイナリの場所を特定
case "$EXT" in
    rs)
        TARGET="${WORKSPACE_DIR}/target/release/main"
        LABEL="Rust (Release)"
        ;;
    c|cpp)
        TARGET="${WORKSPACE_DIR}/main.exe"
        LABEL="C++/C"
        ;;
    py)
        echo "▶ Run Python"
        python3 "$FILE"
        echo "✅ Done"
        exit 0
        ;;
    *)
        echo "❌ Unsupported file type: .$EXT"
        exit 1
        ;;
esac

# コンパイル済みファイルの実行処理（共通）
echo "▶ ${LABEL} バイナリの実行"

if [ -f "$TARGET" ]; then
    # RUST_BACKTRACEを付けてもC++には無害なので一律付与、または分岐
    [ "$EXT" = "rs" ] && export RUST_BACKTRACE=1
    
    # バイナリを実行
    "$TARGET"
else
    echo "❌ Error: Binary not found."
    echo "   Path: $TARGET"
    echo "   Please Build (Ctrl+Shift+B) first."
    exit 1
fi

echo "✅ Done"