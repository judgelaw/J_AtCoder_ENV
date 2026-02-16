#!/usr/bin/env bash
set -e

FILE="$1"
WORKSPACE_ROOT="$(pwd)"
OUT="$WORKSPACE_ROOT/main.exe"

COMPILER="gcc-14"
CFLAGS="-O2
        -march=native
        -std=c23
        -Wall
        -Wextra
        -DONLINE_JUDGE
        -DATCODER
        -DJUDGE_LOCAL"

LIBS="-lm"
echo "🔧 Compile C"
$COMPILER $CXXFLAGS  "$FILE" -o "$OUT" $LIBS

echo "▶ Run"
"$OUT"