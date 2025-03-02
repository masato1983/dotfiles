# ディレクトリ移動時、自動的に pushd コマンドを実行します。
setopt auto_pushd

# すでにディレクトリスタックに存在する場合、pushd コマンドは無視されます。
setopt pushd_ignore_dups

# ディレクトリ名だけで移動可能になります（cd コマンド不必要）。
setopt auto_cd

# history に同じコマンドが存在する場合、そのコマンドは追加されません。
setopt hist_ignore_dups

# 複数の zsh セッション間で、history を共有します。
setopt share_history

# コマンドを実行するたびに、history ファイルに追加します。
setopt inc_append_history

