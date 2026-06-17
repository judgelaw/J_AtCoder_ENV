#!/usr/bin/env bash
set -e

FILE="$1"
WORKSPACE_ROOT="$(pwd)"
OUT="$WORKSPACE_ROOT/main.exe"

COMPILER="g++"
CXXFLAGS="
-std=gnu++2b
-O2
-DONLINE_JUDGE
-DATCODER
-DJUDGE_LOCAL
-Wall
-Wextra
-march=native
-mtune=native
-fconstexpr-depth=2147483647
-fconstexpr-loop-limit=2147483647
-fconstexpr-ops-limit=2147483647
-fopenmp
-pthread
"

INCLUDES="
-I/lib/ac-library
"

LIBS="
-lboost_serialization
-lboost_system
-lgmpxx
-lgmp
-fopenmp
"

echo "🔧 Compile C++"
$COMPILER $CXXFLAGS $INCLUDES "$FILE" -o "$OUT" $LIBS

echo "▶ Run"
"$OUT"