# tmux-navigator
# https://github.com/christoomey/vim-tmux-navigator

set -g @plugin 'christoomey/vim-tmux-navigator'

# On macOS, `ps -o comm=` may return a full path such as `/usr/local/bin/nvim`.
# The plugin's default `(\S+/)?...` pattern can fail with BSD grep -E, which
# prevents tmux from recognizing Neovim panes and forwarding C-h/j/k/l to nvim.
# Override the pattern with a POSIX-compatible version so pane detection stays
# stable even when the command is reported as a full path.
set -g @vim_navigator_pattern '([[:alnum:]_./-]+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
