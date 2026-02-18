# Ubuntu 25.10 ベース
FROM ubuntu:25.10
ENV TZ=Asia/Tokyo\
    DEBIAN_FRONTEND=noninteractive \
    PYENV_ROOT="/root/.pyenv" \
    PATH="/root/.pyenv/shims:/root/.pyenv/bin:/root/.cargo/bin:${PATH}"


# --- 各言語バージョンの定義 ---
ARG GCC_VERSION=14
ARG GPP_VERSION=15
ARG PYTHON_VERSION=3.13.7
ARG RUST_VERSION=1.89.0
ARG ACL_TAG=v1.5.1
ARG ACL_PATH=/lib/ac-library

# パッケージ更新と基本ツール
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
    build-essential \
    gcc-${GCC_VERSION} \
    g++-${GPP_VERSION} \
    git \
    time \
    tree \
    tzdata \
    cmake \
    clang \
    gdb \
    curl \
    nano \
    wget \
    pkg-config \
    libssl-dev \
    libgmp-dev \
    libeigen3-dev \
    libboost-all-dev \
    libbz2-dev \
    libomp-dev \
    zlib1g-dev \
    libz3-dev \
    libreadline-dev \
    libsqlite3-dev \
    liblzma-dev \
    python3 \
    python3-pip \
    python3-venv \
    # --- Live Share 用に追加 ---
    libicu-dev \
    libkrb5-3 \
    zlib1g \
    gnome-keyring \
    desktop-file-utils \
    x11-utils \
    # -------------------------
    && rm -rf /var/lib/apt/lists/*

# Python: pyenvを使ってバージョンを固定
RUN curl https://pyenv.run | bash && \
    export PYENV_ROOT="$HOME/.pyenv" && \
    export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init -)" && \
    pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION} && \
    echo "export PYENV_ROOT=\"\$HOME/.pyenv\"" >> ~/.bashrc && \
    echo "export PATH=\"\$PYENV_ROOT/bin:\$PATH\"" >> ~/.bashrc && \
    echo 'eval "$(pyenv init - --no-rehash)" > /dev/null 2>&1' >> ~/.bashrc

# Rust インストール
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --default-toolchain ${RUST_VERSION} && \
    rustup component add rust-analyzer

# AC Libraryインストール 
RUN git clone --depth 1 \
    -b ${ACL_TAG} \
    https://github.com/atcoder/ac-library.git \
    ${ACL_PATH}

# 作業ディレクトリ
WORKDIR /workspace

# コンテナ起動時にbashを開く
# CMD ["/bin/bash"]
CMD ["sleep", "infinity"]
