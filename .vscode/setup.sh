#!/bin/bash

# 1. 実行権限の付与
chmod +x .vscode/*.sh

# 2. エイリアスの設定（重複追記を防ぐチェック付き）
if ! grep -q "alias gen=" ~/.bashrc; then
    echo "alias gen='./.vscode/gen.sh'" >> ~/.bashrc
fi

# 3. その他必要な初期設定があればここに追加
echo "Setup completed successfully!"