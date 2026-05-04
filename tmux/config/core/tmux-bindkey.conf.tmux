# send-prefix コマンドを C-Space に変更
unbind C-b
bind C-Space send-prefix

# ウィンドウの水平分割を | に変更
unbind %
bind | split-window -h

# ウィンドウの垂直分割を - に変更
unbind '"'
bind - split-window -v

# ペインのリサイズを Vim のキーバインドに変更
# -r オプション（repeatable）で、プレフィックスキーを再度入力する必要がなくなります。
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5
bind -r m resize-pane -Z 5

# コピーモードを Vim のキーバインドに変更
# -T オプション（target）で、コピーモードのキーバインドを指定します。
bind -T copy-mode-vi 'v' send -X begin-selection
bind -T copy-mode-vi 'y' send -X copy-selection

# open opencode in current directory in a popup
bind o popup -E -d "#{pane_current_path}" -w 90% -h 90% "opencode"

# 設定ファイルの再読み込み
bind r source-file ~/.tmux.conf \; display-message "Reloaded!"

# tmux ペインと vim スプリット間のシームレスなナビゲーション
# https://github.com/christoomey/vim-tmux-navigator
#
# README の "Add a snippet" 方式で、プラグイン本体を取得せずに tmux 側のキーバインドだけを定義します。
# https://github.com/christoomey/vim-tmux-navigator#add-a-snippet
#
# macOS の `ps -o comm=` はフルパス（例: `/usr/local/bin/nvim`）を返すことがあり、
# README デフォルトの `\S+\/` パターンは BSD の grep -E と相性が悪く nvim ペインを
# 検出できないことがあります。POSIX 互換の文字クラスに置き換えています。
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +([[:alnum:]_./-]+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\' select-pane -l

# [Sesh](https://github.com/joshmedeski/sesh)
bind "T" run-shell "sesh connect \"$(
	sesh list | fzf-tmux -p 55%,60% \
		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
)\""

bind "K" display-popup -E -w 40% "sesh connect \"$(
	sesh list -i | gum filter --limit 1 --placeholder 'Pick a sesh' --height 50 --prompt='⚡'
)\""
