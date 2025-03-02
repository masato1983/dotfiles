# cd
cx() { cd "$@" && l; }

# creating directories
function take {
    mkdir -p "$1" && cd "$1"
}

# cp
function cpbak {
  for file in "$@"; do
    cp -ivp "$file" "$file.bak"
  done
}

# [Sesh keybing](https://github.com/joshmedeski/sesh?tab=readme-ov-file#zsh-keybind)
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

# 画像の縦横のサイズを、標準出力に表示し、クリップボードにもコピーします。
# 使用ツール identify（MAMP/Library/bin の PATH を通しておきます）
# 使用例: get_image_size http://example.com/image.png
function gis {
    for file in "$@"; do
        local size=$(curl -s "$file" | identify -format 'width="%w" height="%h"' -)
        echo "$file $size"
        echo -n "$size" | pbcopy
    done
}

# 画像からテキストを抽出します。
# 抽出したテキストは標準出力に表示し、クリップボードにもコピーします。
# 使用ツール tesseract, tesseract-lang (brew install tesseract tesseract-lang)
# 使用例 extract_text_from_image http://example.com/image.png
function extract_text_from_image {
    for file in "$@"; do
        local url="$file"
        local tempfile="temp-$(basename $file)"

        curl -s "$url" -o "$tempfile"

        local extracted_text=$(tesseract "$tempfile" stdout -l jpn)

        echo "$extracted_text"
        echo -n "$extracted_text" | pbcopy

        rm -f "$tempfile"
    done
}

# git
gax() { gst | grep "$1" | awk '{print $NF}' | xargs git add && gst; }
grx() { gst | grep "$1" | awk '{print $NF}' | xargs git restore --staged && gst; }
gdx() { gst | grep "$1" | awk '{print $NF}' | xargs git diff; }
glx() { glog --grep="$@" --no-merges; }

# vim
vx() { gst | grep "$1" | awk '{print $NF}' | xargs nvim; }

# fd
fd0x() { fd --hidden --changed-within $(date -v-0d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-0d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd1x() { fd --hidden --changed-within $(date -v-1d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-1d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd2x() { fd --hidden --changed-within $(date -v-2d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-2d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd3x() { fd --hidden --changed-within $(date -v-3d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-3d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd4x() { fd --hidden --changed-within $(date -v-4d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-4d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd5x() { fd --hidden --changed-within $(date -v-5d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-5d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd6x() { fd --hidden --changed-within $(date -v-6d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-6d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }
fd7x() { fd --hidden --changed-within $(date -v-7d "+%Y-%m-%d") --type file | xargs eza --long | grep "$(date -v-7d "+%-d %-m")" | awk '{print $NF}' | xargs eza --all --long --git --octal-permissions --icons=auto --color-scale=size --sort=modified --time-style='+%m-%d %H:%M'; }

