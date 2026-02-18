#!/usr/bin/env bash
set -e

# ===== 引数チェック =====
FILE="$1"
if [ -z "$FILE" ]; then
    echo "Usage: $0 <rust-file>"
    exit 1
fi

EXT="${FILE##*.}"
if [ "$EXT" != "rs" ]; then
    echo "Error: Not a Rust file: $FILE"
    exit 1
fi

# ===== workspace 直下を基準 =====
WORKSPACE_DIR="$(pwd)"  # run.sh を workspace 直下で実行する前提
SRC_DIR="${WORKSPACE_DIR}/src"
MAIN_RS="${SRC_DIR}/main.rs"


# ===== src ディレクトリ作成 =====
mkdir -p "$SRC_DIR"

# ===== Rust ファイルを main.rs にコピー =====
cp "$FILE" "$MAIN_RS"
echo "Copied $FILE → $MAIN_RS"

CARGO_TOML="${WORKSPACE_DIR}/Cargo.toml"
if [ ! -f "$CARGO_TOML" ]; then
    echo "Creating default Cargo.toml..."
    cat > "$CARGO_TOML" <<EOL
[package]
name = "main"
version = "0.1.0"
edition = "2024"
publish = false

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[features]
default = []
judge_local =[]

[dependencies]
# 202411から:
rpds = "=1.1.1"
rand_xorshift = "=0.4.0"
rand_xoshiro = "=0.7.0"
statrs = "=0.18.0"
primal = "=0.3.3"
thiserror = "=2.0.16"
# 202301から:
ac-library-rs = "=0.2.0"
once_cell = "=1.21.3"
static_assertions = "=1.1.0"
varisat = "=0.2.2"
memoise = "=0.3.2"
argio = "=0.2.0"
bitvec = "=1.0.1"
counter = "=0.7.0"
hashbag = "=0.1.12"
pathfinding = "=4.14.0"
recur-fn = "=2.2.0"
indexing = { version = "=0.4.1", features = ["experimental_pointer_ranges"] }
amplify = { version = "=4.9.0", features = ["c_raw", "rand", "stringly_conversions"] }
amplify_derive = "=4.0.1"
amplify_num = { version = "=0.5.3", features = ["std"] }
easy-ext = "=1.0.2"
multimap = "=0.10.1"
btreemultimap = "=0.1.1"
bstr = "=1.12.0"
az = "=1.2.1"
glidesort = "=0.1.2"
tap = "=1.0.1"
omniswap = "=0.1.0"
multiversion = "=0.8.0"
# 202004から続投:
num = "=0.4.3"
num-bigint = "=0.4.6"
num-complex = "=0.4.6"
num-integer = "=0.1.46"
num-iter = "=0.1.45"
num-rational = "=0.4.2"
num-traits = "=0.2.19"
num-derive = "=0.4.2"
ndarray = "=0.16.1"
nalgebra = "=0.34.0"
alga = "=0.9.3"
libm = "=0.2.15"
rand = "=0.9.2"
getrandom = "=0.3.3"
rand_chacha = "=0.9.0"
rand_core = "=0.9.3"
rand_hc = "=0.4.0"
rand_pcg = "=0.9.0"
rand_distr = "=0.5.1"
petgraph = "=0.8.2"
indexmap = "=2.11.0"
regex = "=1.11.2"
lazy_static = "=1.5.0"
ordered-float = "=5.0.0"
ascii = "=1.1.0"
permutohedron = "=0.2.4"
superslice = "=1.0.0"
itertools = "=0.14.0"
itertools-num = "=0.1.3"
maplit = "=1.0.2"
either = "=1.15.0"
im-rc = "=15.1.0"
fixedbitset = "=0.5.7"
bitset-fixed = "=0.1.0"
proconio = { version = "=0.5.0", features = ["derive"] }
text_io = "=0.1.13"
rustc-hash = "=2.1.1"
smallvec = { version = "=1.15.1", features = ["const_generics", "const_new", "write", "union", "serde", "arbitrary"] }

[[bin]]
name = "main"
path = "src/main.rs"
EOL
fi

# ===== オンラインで依存を取得（初回のみ） =====
if [ ! -d "${WORKSPACE_DIR}/target" ]; then
    echo "🔗 Fetching dependencies online..."
    cargo fetch --manifest-path "$CARGO_TOML"
fi

# ===== ビルド / 実行 =====
echo "🔧 Compile Rust"
cargo build --release --manifest-path "$CARGO_TOML" --offline

echo "▶ Run"
RUST_BACKTRACE=1 cargo run --release --quiet --manifest-path "$CARGO_TOML" --offline

echo "✅ Done"