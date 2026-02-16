#!/bin/bash

# スクリプトの場所に関わらず、リポジトリのルートを取得
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
INPUT=$1
shift # 最初の引数（コンテスト名）を捨てる

if [ -z "$INPUT" ]; then
    echo "使用法: gen [コンテスト名] [問題数と使用する言語(任意: c/cpp/py/rs)]"
    echo "例: gen abc350       (ABCならデフォルトで7つ作成します、AWCなら5つ、ADTは9つ、それ以外は6つ作成します)"
    echo "例: gen arc150 6     (A-Fの6つ作成、最大26問まで作成できます)"
    exit 1
fi

# --- 1. 引数の解析 (数と言語を抽出) ---
$COUNT=""
for arg in "$@"; do
    if [[ "$arg" =~ ^[0-9]+$ ]]; then
        COUNT=$arg
    elif [[ "$arg" =~ ^(c|cpp|py|rs)$ ]]; then
        LANGS+=("$arg")
    fi
done

# 言語デフォルト値の設定(初期設定はcpp)
[ ${#LANGS[@]} -eq 0 ] && LANGS=("cpp")


# --- 2. PREFIX大文字化など ---
RAW_PREFIX=${INPUT:0:3}
PREFIX=$(echo "$RAW_PREFIX" | tr '[:lower:]' '[:upper:]')
SUFFIX=${INPUT:3}

# --- 3. ディレクトリ階層の決定 (純粋にパスだけを決める) ---
case "$PREFIX" in
    "ABC" | "ARC" | "AGC" | "AHC" | "AWC" | "ADT")
        # 特定のコンテストは種類ごとのフォルダに格納
        BASE_DIR="$ROOT_DIR/$PREFIX/$SUFFIX"
        ;;
    *)
        # それ以外はすべて OtherContest フォルダに格納
        BASE_DIR="$ROOT_DIR/OtherContest/$INPUT"
        ;;
esac

# --- 4. 作成数の決定 (コンテスト種別ごとのデフォルト設定) ---
if [ -n "$COUNT" ]; then
    COUNT=$COUNT
elif [ "$PREFIX" == "ABC" ]; then
    COUNT=7
elif [ "$PREFIX" == "AWC" ]; then
    COUNT=5
elif [ "$PREFIX" == "ADT" ]; then
    COUNT=9
else
    COUNT=6
fi

# --- 5. ファイル生成処理 ---
get_alphabet() {
    local n=$1
    local s=""
    while [ "$n" -gt 0 ]; do
        n=$((n - 1))
        local m=$((n % 26))
        local char=$(printf "\\$(printf '%o' $((m + 65)))")
        s="$char$s"
        n=$((n / 26))
    done
    echo "$s"
}

mkdir -p "$BASE_DIR"

echo "Target Directory: $BASE_DIR"
echo "Problem Count   : $COUNT"


# 指定された数だけファイルを生成
for ((i=1; i<=COUNT; i++)); do
    p=$(get_alphabet $i)
    
    for lang in "${LANGS[@]}"; do
        TEMPLATE_FILE="$ROOT_DIR/template/template.$lang"
        FILENAME="$p.$lang"
        TARGET_FILE="$BASE_DIR/$FILENAME"
        
        # ファイル（またはディレクトリ）がすでに存在するかチェック
        if [ -e "$TARGET_FILE" ]; then
            echo "Skipped: $FILENAME (already exists)"
        else
            # 存在しない場合のみ、テンプレートをコピーまたは新規作成
            if [ -f "$TEMPLATE_FILE" ]; then
                cp "$TEMPLATE_FILE" "$TARGET_FILE"
                echo "Created: $FILENAME (from template)"
            else
                touch "$TARGET_FILE"
                echo "Created: $FILENAME (empty file)"
            fi
        fi
    done
done

echo "Successfully created: $BASE_DIR"