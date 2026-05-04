# Set the TERM environment variable inside tmux to screen-256color.
set -g default-terminal "screen-256color"

# Do not detach from tmux when a session is destroyed (kill-session).
set -g detach-on-destroy off

# Set the prefix key to C-Space.
set -g prefix C-Space

# Enable mouse support.
set -g mouse on

# Start window index from 1.
set -g base-index 1

# Enable automatic window renumbering.
set -g renumber-windows on

# Set the ESC key delay to 0.
set -gs escape-time 0

# Use vi keybindings in copy mode.
set-window-option -g mode-keys vi

# [yazi](https://yazi-rs.github.io/docs/image-preview#tmux)
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM

# [pi-mono](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/tmux.md)
set -g extended-keys on
set -g extended-keys-format csi-u
