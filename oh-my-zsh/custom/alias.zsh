# general
alias cl='clear'
alias e='exit'
alias s='source ~/.zshrc'

# cd
alias home='cd ~/'
alias download='cd ~/Download'
alias dotfiles='cd ~/.dotfiles'
alias kapture='cd ~/Movies/Kaptures'
alias trash='cd ~/.local/share/Trash'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'

# echo
alias exitcode='echo $?'

# pwd
alias pwdcp='pwd | tee >(pbcopy)'

# global
alias -g B='| bat'
alias -g C='| pbcopy'
alias -g F='| fzf'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| wc -l'
alias -g LESS='| less'
alias -g S='| sort'
alias -g T='| tail'
alias -g U='| uniq'
alias -g X='| xargs'

# 先頭と末尾の空白を削除し、連続する空白を1つに置き換え
alias trim="awk '{\$1=\$1;print}'"

# cp
alias cpf='cp -vi'
alias cpfp='cp -vip'
alias cpdir='cp -viR'
alias cpdirp='cp -vipR'

# fzf
alias fpb="fzf --preview 'bat --color=always {}' | tee >(pbcopy)"
alias fvim="fzf --preview 'bat --color=always {}' | xargs nvim"
alias fga="fzf --preview 'bat --color=always {}' | xargs git add"

# rm
alias rm='rm -i'

# stat
alias stat='stat -x'

# IP address
alias ipp='curl ipinfo.io'
alias ipen0='ipconfig getifaddr en0'
alias ipen1='ipconfig getifaddr en1'

# xserver
alias xserver-upload='rsync -avhe "ssh -p 10022" --delete --update --exclude-from=".rsyncignore" ./ masa1122@sv7051.xserver.jp:/home/masa1122/coding11ty.com/public_html/test.coding11ty.com/'

# homebrew
alias brewup='brew update && brew upgrade && brew cleanup && brew doctor'
alias bbd='cpbak ~/.dotfiles/Brewfile && trash-put ~/.dotfiles/Brewfile && brew bundle dump'
alias bbi='brew bundle install --file=~/.dotfiles/Brewfile'
alias bbc='brew bundle cleanup --file=~/.dotfiles/Brewfile'

# vim
alias v='nvim'
alias view='nvim -R'

# tmux
alias t='tmux'
alias tl='tmux ls'
alias tsl='l /tmp/tmux-501'
alias td='tmux detach'
alias tas='tmux attach-session -t'
alias tls='tmux list-sessions || tmux ls'
alias tns='tmux new-session -s'
alias tks='tmux kill-session -t'

# ripgrep
alias rgh='rg --hidden --glob "!.git" --glob "!package-lock.json"'
alias rgl='rg --files-with-matches'
alias rghl='rg --hidden --files-with-matches --glob "!.git" --glob "!package-lock.json"'

# tree
alias tree-all='tree -a -I .git'
alias tree-all-links='tree -a -l -I .git'

# github cli
alias ghb='gh browse'

# fork
alias f='fork'

# lazygit
alias lg='lazygit'

# exa
alias l='eza --all --long --git --octal-permissions --no-user --icons=auto --color=always --color-scale=all --sort=modified --time-style=relative'
alias lt='eza --all --long --git --octal-permissions --no-user --icons=auto --color=always --color-scale=all --sort=modified --time-style=relative --tree --level=2 --ignore-glob=".git|node_modules"'

# clipboard
alias tolower="pbpaste | tr '[:upper:]' '[:lower:]' | pbcopy"
alias toupper="pbpaste | tr '[:lower:]' '[:upper:]' | pbcopy"

# identify
alias dis="identify -format 'サイズ: %b ピクセル寸法: %wx%h\n'"

# history
alias history='fc -li 1'

# gsed (GNU sed)
alias sed-empty='gsed -i "/^$/d"'                               # 空行を削除
alias sed-blank='gsed -i "/^[[:space:]]*$/d"'                   # 空白のみの行も削除
alias sed-num='gsed -i "/^[0-9]*$/d"'                           # 数字だけの行を削除
alias sed-alpha='gsed -i "/^[a-zA-Z]*$/d"'                      # アルファベットだけの行を削除
alias sed-symbol='gsed -i "/^[[:punct:][:space:]]*$/d"'         # 記号・空白だけの行を削除
alias sed-comment='gsed -i "/^#/d"'                             # コメント行を削除
alias sed-trim='gsed -i "s/^[[:space:]]*//;s/[[:space:]]*$//"'  # 前後の空白を削除
alias sed-ltrim='gsed -i "s/^[[:space:]]*//"'                   # 先頭の空白を削除
alias sed-rtrim='gsed -i "s/[[:space:]]*$//"'                   # 末尾の空白を削除
alias sed-spaces='gsed -i "s/[[:space:]]\+/ /g"'                # 連続する空白を1つに
alias sed-lower='gsed -i "s/.*/\L&/"'                           # 小文字に変換
alias sed-upper='gsed -i "s/.*/\U&/"'                           # 大文字に変換
alias sed-first='gsed -i "1!d"'                                 # 最初の行のみ残す
alias sed-last='gsed -i "$!d"'                                  # 最後の行のみ残す
alias sed-nocolor='gsed -i "s/\x1b\[[0-9;]*m//g"'               # ANSIカラーコードを削除
alias sed-crlf='gsed -i "s/\r$//"'                              # CRLF を LF に変換
