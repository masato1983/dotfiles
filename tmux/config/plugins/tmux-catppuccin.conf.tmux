# catppuccino theme
# https://github.com/catppuccin/tmux?tab=readme-ov-file

# use catppuccino theme
set -g @plugin 'catppuccin/tmux'
set -g @catppuccin_flavor 'mocha'

# set window style
set -g @catppuccin_window_left_separator ""
set -g @catppuccin_window_right_separator " "
set -g @catppuccin_window_middle_separator " █"
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_window_default_fill "number"
set -g @catppuccin_window_default_text "#{b:pane_current_path}"
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_current_text "#{b:pane_current_path}"

# set status style
set -g @catppuccin_status_modules_right "directory session date_time"
set -g @catppuccin_status_left_separator  " "
set -g @catppuccin_status_right_separator ""
set -g @catppuccin_status_right_separator_inverse "no"
set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_connect_separator "no"
set -g @catppuccin_directory_text "#{pane_current_path}"

