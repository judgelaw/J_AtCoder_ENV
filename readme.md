# J AtCoder Environment Container

AtCoderのジャッジサーバーと**ほぼ同等のコンパイルオプション・実行環境**を、VS Code + Dockerで手軽に再現するための開発コンテナです。

### 対応言語
* C / C++
* Python 3
* Rust

---

## 1. 準備するもの

### 推奨PC環境
DockerおよびWSL2を安定して動作させるため、以下の環境を推奨します。
* **メモリ**: 最低 4GB（**8GB以上**を強く推奨）
* **ストレージ**: 10GB 以上の空き容量
* **OS**: Windows 10/11 (64bit)

実行にあたり、以下のツールがインストールされている必要があります。

* **VS Code**
* **Dev Containers** (VS Code 拡張機能)
* **Docker Desktop** (または Docker Engine)
* **WSL 2** (Windowsユーザーの場合)

## 2. インストールされる拡張機能
このコンテナを開くと、以下の拡張機能が自動的にインストールされ、すぐに利用可能になります。

■ C/C++ 開発
- ms-vscode.cpptools
- ms-vscode.cpptools-themes
- ms-vscode.cmake-tools

■ Python 開発
- ms-python.python
- ms-python.vscode-pylance
- ms-python.debugpy

■ Rust 開発
- rust-lang.rust-analyzer
- vadimcn.vscode-lldb

■ 便利ツール
- ms-vsliveshare.vsliveshare (共同作業)
- usernamehw.errorlens (エラーの行内表示)


## 3. セットアップ手順

### 手順 A：プロジェクトの取得 (初回のみ)
以下の手順などで、PCにリポジトリを複製できます。
#### 方法1：VS Codeの機能を使う（推奨）
1. VS Codeを起動し、メニューの **[ファイル] > [新しいウィンドウ]** を開きます（または「開始」ページを表示）。
2. **[Git リポジトリのクローン]** をクリックします。
3. このリポジトリのURLを貼り付けて `Enter` を押します。
   `https://github.com/judgelaw/J_AtCoder_ENV.git`
4. 保存先のフォルダを選択すると、自動的にダウンロードが始まります。

#### 方法2：コマンドを使う
ターミナル（コマンドプロンプトやPowerShellなど）を開き、任意のフォルダで以下のコマンドを実行してプロジェクトをダウンロードします。

```bash
git clone https://github.com/judgelaw/J_AtCoder_ENV.git
```

### 手順 B：.wslconfigファイルの設定

1. 本フォルダにある `.wslconfig` ファイルをテキストエディタで開きます。
2. **自身のPCスペックに合わせて、メモリ（memory）やCPUコア数（processors）の記述を適宜書き換えてください。**
   - ※実装量の半分程度までにした方がいいと思います。
3. 書き換えたファイルを `C:\Users\<ユーザー名>\` フォルダへ貼り付けます。
### 手順 C：コンテナの起動
1. **プロジェクトを開く**
   本フォルダをVS Codeで開きます。
2. **コンテナを起動する**
   画面左下のアイコン（`><`）をクリックし、**[コンテナで再度開く / Reopen in Container]** を選択してください。
> [!WARNING]
> 初回起動時はイメージのビルドに**約10分**ほどかかります。進捗は右下の通知から「ログの表示」を選択して確認できます。止まっているように見えても、バックグラウンドで処理が進んでいるのでそのままお待ちください。

3. **コードを実行する**
   コンテナ内での起動が完了したら、ソースコードを作成して以下のショートカットで実行できます。

## 4. ショートカットキー

本環境では、スムーズなコード実行のために以下の設定を用意しています。

| 操作 | ショートカット | 内容 |
| :--- | :--- | :--- |
| **ビルド・実行** | `Ctrl` + `Shift` + `B` | ジャッジ環境に近いオプションでコンパイルし、実行します。 |
| **実行のみ** | `Ctrl` + `F1` | コンパイルをスキップして、直前のバイナリを実行します。 |

> [!NOTE]
> `Ctrl + F1` を有効にするには、`/.vscode/keybind.json` の内容を、お使いのVS Code本体の `keybindings.json` にコピーして貼り付けてください。

---