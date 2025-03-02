# 前方一致で履歴検索します。
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# [Sesh keybing](https://github.com/joshmedeski/sesh?tab=readme-ov-file#zsh-keybind)
zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
