# Ubuntu 25.10 ベース
FROM ubuntu:25.10
ENV TZ=Asia/Tokyo


# 非対話モードでaptを実行できるようにする
ENV DEBIAN_FRONTEND=noninteractive

# パッケージ更新と基本ツール
ARG GCC_VERSION=15
RUN apt update && apt upgrade -y && \
    apt install -y build-essential \
    gcc-${GCC_VERSION} \
    g++-${GCC_VERSION} \
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

# Rust インストール
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup component add rust-analyzer

# C++用ArCoderLibrary インストール
ARG ACL_TAG=v1.5.1
ARG ACL_PATH=/lib/ac-library

RUN git clone --depth 1 \
    -b ${ACL_TAG} \
    https://github.com/atcoder/ac-library.git \
    ${ACL_PATH}

# 作業ディレクトリ
WORKDIR /workspace

# コンテナ起動時にbashを開く
# CMD ["/bin/bash"]
CMD ["sleep", "infinity"]
