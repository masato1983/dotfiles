# tmux 内での TERM 環境変数を screen-256color に設定します。
set -g default-terminal "screen-256color"

# セッション破棄（kill-session）時に、tmux からデタッチしないようにします。
# 他のセッションにアタッチするようになります。
set -g detach-on-destroy off

# プレフィックスキーを C-Space に設定します。
set -g prefix C-Space

# マウス操作を有効にします。
set -g mouse on

# ウィンドウのインデックスを 1 から始めます。
set -g base-index 1

# ウィンドウの自動ナンバリングを有効にします。
set -g renumber-windows on

# ステータスバーを非表示にします。
set -g status off

# ステータスバーを上部に表示します。
# set -g status-position top

# ステータスバーに表示されるメッセージの表示時間を設定します。
# set -g display-time 1500

# ESC キーのディレイを 0 に設定します。
set -gs escape-time 0

# コピーモードで vi のキーバインドを使用します。
set-window-option -g mode-keys vi

# [Yazi](https://yazi-rs.github.io/docs/image-preview#tmux)
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM
