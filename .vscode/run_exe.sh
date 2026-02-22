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
        DIR_PART=$(dirname "$FILE")    # ABC/300
        FILE_PART=$(basename "$FILE")   # A.rs

        SUFFIX=$(echo "$DIR_PART" | rev | cut -d'/' -f1 | rev) # 000
        PREFIX=$(echo "$DIR_PART" | rev | cut -d'/' -f2 | rev) # ABC

        # ファイル名から拡張子を除去 (A.rs -> A)
        PROBLEM="${FILE_PART%.*}"

        # BIN_NAME を作成 (gen.sh の規則に合わせる: abc300_a)
        BIN_NAME=$(echo "${PREFIX}${SUFFIX}_${PROBLEM}")

        TARGET="${WORKSPACE_DIR}/release/${BIN_NAME}"
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