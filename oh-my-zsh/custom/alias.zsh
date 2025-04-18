# general
alias c='code .'
alias cl='clear'
alias e='exit'
alias s='source ~/.zshrc'

# cd
alias home='cd ~/'
alias download='cd ~/Download'
alias omz='cd ~/.oh-my-zsh'
alias dotfiles='cd ~/.dotfiles'
alias kapture='cd ~/Movies/Kaptures'
alias trash='cd ~/.local/share/Trash'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias appsupport='cd ~/Library/Application\ Support'
alias mamp='cd /Applications/MAMP'

# echo
alias exitcode='echo $?'

# pwd
alias pwdcp='pwd | tee >(pbcopy)'

# edit
alias zshrc='nvim ~/.zshrc'
alias zprofile='nvim ~/.zprofile'

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

# php server
alias psl='php -S localhost:8000 -t'
alias pse='php -S 192.168.0.252:8000 -t'

# xserver
alias xserver-upload='rsync -avhe "ssh -p 10022" --delete --update --exclude-from=".rsyncignore" ./ masa1122@sv7051.xserver.jp:/home/masa1122/coding11ty.com/public_html/test.coding11ty.com/'

# oh my zsh
alias opg='cd /Users/masato/.oh-my-zsh/plugins/git/'
alias opn='cd /Users/masato/.oh-my-zsh/plugins/npm/'
alias opn='cd /Users/masato/.oh-my-zsh/plugins/rsync/'

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

# fd
alias fdf='fd --type file'
alias fdd='fd --type directory'
alias fd0='fd --hidden --changed-within $(date -v-0d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd1='fd --hidden --changed-within $(date -v-1d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd2='fd --hidden --changed-within $(date -v-2d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd3='fd --hidden --changed-within $(date -v-3d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd4='fd --hidden --changed-within $(date -v-4d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd5='fd --hidden --changed-within $(date -v-5d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd6='fd --hidden --changed-within $(date -v-6d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'
alias fd7='fd --hidden --changed-within $(date -v-7d '+%Y-%m-%d') --type file -X eza --all --long --git --octal-permissions --icons=auto --color-scale=all --sort=modified --time-style="+%m-%d %H:%M"'

# riggrep (Search string in files)
alias rgg='rg --files-with-matches --no-messages'

# tree
alias tree-all='tree -a -I .git'
alias tree-all-links='tree -a -l -I .git'

# git
alias grpa='git restore --patch'
alias grpas='git restore --patch --staged'
alias gpod='git pull origin develop'
alias gdu='git diff $(git_current_branch)..origin/$(git_current_branch)'
alias gdun='git diff $(git_current_branch)..origin/$(git_current_branch) --name-status'
alias gloggp='git log --graph --pretty="%Cred%h%Creset %s -%C(auto)%d%Creset %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias gloggpa='git log --graph --pretty="%Cred%h%Creset %s -%C(auto)%d%Creset %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias gloggps='git log --graph --pretty="%Cred%h%Creset %s -%C(auto)%d%Creset %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias gcpn='git cherry-pick --no-commit'
alias gpot='git push origin --tags'

# github cli
alias ghb='gh browse'
alias ghil='gh issue list'
alias ghol='gh org list'
alias ghprc='gh pr create'
alias ghprm='gh pr merge'  
alias ghprl='gh pr list'
alias ghprlc='gh pr list --closed'
alias ghrv='gh repo view'
alias ghrl='gh run list'
alias ghrw='gh run watch'

# lazygit
alias lg='lazygit'

# exa
alias l='eza --all --long --git --octal-permissions --no-user --icons=auto --color=always --color-scale=all --sort=modified --time-style=relative'
alias lt='eza --all --long --git --octal-permissions --no-user --icons=auto --color=always --color-scale=all --sort=modified --time-style=relative --tree --level=2 --ignore-glob=".git|node_modules"'

# clipboard
alias tolower="pbpaste | tr '[:upper:]' '[:lower:]' | pbcopy"
alias toupper="pbpaste | tr '[:lower:]' '[:upper:]' | pbcopy"

# php cs fixer
alias csfixer='php tools/php-cs-fixer/vendor/bin/php-cs-fixer'

# php stan
alias stan='vendor/bin/phpstan analyse'

# shellcheck
alias sc='shellcheck --color=always'

# identify
alias dis="identify -format 'サイズ: %b ピクセル寸法: %wx%h\n'"

# other
alias portcheck8888='sudo lsof -P -i:8888'
