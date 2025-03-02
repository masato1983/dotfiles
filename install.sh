#!/bin/bash
set -e
set -o pipefail

# このスクリプトは、dotfiles のインストールと設定を行います。

####################################################################################################
# リポジトリをダウンロードします。
####################################################################################################

if [ ! -d ~/.dotfiles ]; then
	gh repo clone glideartsstudio-personal/furuta-dotfiles ~/.dotfiles
else
	echo "Error: Directory ~/.dotfiles already exists."
fi

####################################################################################################
# シンボリックリンクを作成します。
####################################################################################################

# git
if [ ! -f ~/.gitconfig ]; then
	ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
else
	echo "Error: File ~/.gitconfig already exists."
fi

if [ ! -f ~/Glide/.gitignore ]; then
	ln -s ~/.dotfiles/git/glide/.gitconfig ~/Glide/.gitconfig
else
	echo "Error: File ~/Glide/.gitconfig already exists."
fi

# zsh
if [ ! -f ~/.zshrc ]; then
	ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
else
	echo "Error: File ~/.zshrc already exists."
fi

# bat
if [ ! -d ~/.config/bat ]; then
	ln -s ~/.dotfiles/bat ~/.config/bat
	bat cache --build
else
	echo "Error: Directory ~/.config/bat already exists."
fi

# starship
if [ ! -f ~/.config/starship.toml ]; then
	ln -s ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
	{
		echo "# starship"
		echo "# https://starship.rs/"
		echo "eval '$(starship init zsh)'"
	} >>~/.zshrc
	source ~/.zshrc
else
	echo "Error: File ~/.config/starship.toml already exists."
fi

# tmux
if [ ! -d ~/.config/tmux ]; then
	ln -s ~/.dotfiles/tmux/config ~/.config/tmux
	tmux new -s "$(pwd | sed 's/.*\///g')"
	tmux source-file ~/.tmux.conf
	~/.tmux/plugins/tpm/bin/clean_plugins
	~/.tmux/plugins/tpm/bin/install_plugins
	~/.tmux/plugins/tpm/bin/update_plugins all
else
	echo "Error: Directory ~/.config/tmux already exists."
fi

# .tmux.conf
if [ ! -f ~/.tmux.conf ]; then
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
else
	echo "Error: File ~/.tmux.conf already exists."
fi

# oh-my-zsh - alias.zsh
if [ ! -f ~/.oh-my-zsh/custom/alias.zsh ]; then
	ln -s ~/.dotfiles/oh-my-zsh/custom/alias.zsh ~/.oh-my-zsh/custom/alias.zsh
else
	echo "Error: File ~/.oh-my-zsh/custom/alias.zsh already exists."
fi

# oh-my-zsh - bindkey.zsh
if [ ! -f ~/.oh-my-zsh/custom/bindkey.zsh ]; then
	ln -s ~/.dotfiles/oh-my-zsh/custom/bindkey.zsh ~/.oh-my-zsh/custom/bindkey.zsh
else
	echo "Error: File ~/.oh-my-zsh/custom/bindkey.zsh already exists."
fi

# oh-my-zsh - functions.zsh
if [ ! -f ~/.oh-my-zsh/custom/functions.zsh ]; then
	ln -s ~/.dotfiles/oh-my-zsh/custom/functions.zsh ~/.oh-my-zsh/custom/functions.zsh
else
	echo "Error: File ~/.oh-my-zsh/custom/functions.zsh already exists."
fi

# oh-my-zsh - options.zsh
if [ ! -f ~/.oh-my-zsh/custom/options.zsh ]; then
	ln -s ~/.dotfiles/oh-my-zsh/custom/options.zsh ~/.oh-my-zsh/custom/options.zsh
else
	echo "Error: File ~/.oh-my-zsh/custom/options.zsh already exists."
fi

# oh-my-zsh - path.zsh
if [ ! -f ~/.oh-my-zsh/custom/path.zsh ]; then
	ln -s ~/.dotfiles/oh-my-zsh/custom/path.zsh ~/.oh-my-zsh/custom/path.zsh
else
	echo "Error: File ~/.oh-my-zsh/custom/path.zsh already exists."
fi

# nvim
if [ ! -d ~/.config/nvim ]; then
	ln -s ~/.dotfiles/nvim ~/.config/nvim
else
	echo "Error: Directory ~/.config/nvim already exists."
fi

# nvm
if [ ! -f ~/.nvm/default-packages ]; then
	ln -s ~/.dotfiles/nvm/default-packages ~/.nvm/default-packages
else
	echo "Error: File ~/.nvm/default-packages already exists."
fi

# Brewfile
if [ ! -f ~/Brewfile ]; then
	ln -s ~/.dotfiles/homebrew/Brewfile ~/Brewfile
else
	echo "Error: File ~/Brewfile already exists."
fi

# Brewfile.lock.json
if [ ! -f ~/Brewfile.lock.json ]; then
	ln -s ~/.dotfiles/homebrew/Brewfile.lock.json ~/Brewfile.lock.json
else
	echo "Error: File ~/Brewfile.lock.json already exists."
fi

# Neovim Executable Paths: Darwin for VSCode
if [ "$HOMEBREW_PREFIX" = "/usr/local" ]; then
	sudo ln -s "$(which nvim)" /opt/homebrew/bin/nvim
fi

# Shellchck Executable Paths: for VSCode
if [ "$HOMEBREW_PREFIX" = "/usr/local" ]; then
	sudo ln -s "$(which shellcheck)" /opt/homebrew/bin/shellcheck
fi

# .fdignore
if [ ! -f ~/.fdignore ]; then
	ln -s ~/.dotfiles/fd/.fdignore ~/.fdignore
else
	echo "Error: File ~/.fdignore already exists."
fi

# .rgignore
if [ ! -f ~/.rgignore ]; then
	ln -s ~/.dotfiles/ripgrep/.rgignore ~/.rgignore
else
	echo "Error: File ~/.rgignore already exists."
fi

# VSCode - settings.json
if [ ! -f ~/Library/Application\ Support/Code/User/settings.json ]; then
	ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
else
	echo "Error: File ~/Library/Application\ Support/Code/User/settings.json already exists."
fi

# VSCode - keybindings.json
if [ ! -f ~/Library/Application\ Support/Code/User/keybindings.json ]; then
	ln -s ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
else
	echo "Error: File ~/Library/Application\ Support/Code/User/keybindings.json already exists."
fi

# VSCode - tasks.json
if [ ! -f ~/Library/Application\ Support/Code/User/tasks.json ]; then
	ln -s ~/.dotfiles/vscode/tasks.json ~/Library/Application\ Support/Code/User/tasks.json
else
	echo "Error: File ~/Library/Application\ Support/Code/User/tasks.json already exists."
fi

# VSCode - snippets
if [ ! -d ~/Library/Application\ Support/Code/User/snippets ]; then
	ln -s ~/.dotfiles/vscode/snippets ~/Library/Application\ Support/Code/User/snippets
else
	echo "Error: Directory ~/Library/Application\ Support/Code/User/snippets already exists."
fi

####################################################################################################
# Homebrew のパッケージをインストールします。
# brew コマンドに関しては、以下の URL を参照してください。
# https://github.com/glideartsstudio-documents/frontend-dev/blob/main/docs/global/homebrew.md#bundle
####################################################################################################

$()$(
	sh
	brew cp Brewfile Brewfile.bak
)$()

$()$(
	sh
	brew bundle install
)$()

$()$(
	sh
	brew bundle cleanup
)$()

####################################################################################################
# oh-my-zsh プラグインのインストールと設定を行います。
####################################################################################################
