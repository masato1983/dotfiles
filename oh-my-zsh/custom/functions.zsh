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

# ディレクトリの再帰コピー（rsync版）
# 使用例: syncdir /path/to/source /path/to/target
function syncdir {
	if [[ $# -ne 2 ]]; then
		echo "Usage: syncdir <source_dir> <target_dir>"
		return 1
	fi

	local src="$1"
	local dst="$2"

	if [[ ! -d "$src" ]]; then
		echo "Error: Source directory '$src' does not exist."
		return 1
	fi

	if [[ ! -d "$dst" ]]; then
		echo "Error: Target directory '$dst' does not exist."
		return 1
	fi

	echo "Source: $src"
	echo "Target: $dst"
	echo -n "Sync all files from source to target? [y/N]: "
	read -r confirm
	if [[ "$confirm" =~ ^[Yy]$ ]]; then
		rsync -av "$src/" "$dst/"
		echo "Sync completed."
	else
		echo "Cancelled."
	fi
}

# ディレクトリの再帰コピー（cp版）
# 使用例: cpmerge /path/to/source /path/to/target
function cpmerge {
	if [[ $# -ne 2 ]]; then
		echo "Usage: cpmerge <source_dir> <target_dir>"
		return 1
	fi

	local src="$1"
	local dst="$2"

	if [[ ! -d "$src" ]]; then
		echo "Error: Source directory '$src' does not exist."
		return 1
	fi

	if [[ ! -d "$dst" ]]; then
		echo "Error: Target directory '$dst' does not exist."
		return 1
	fi

	echo "Source: $src"
	echo "Target: $dst"
	echo -n "Copy all files from source to target? [y/N]: "
	read -r confirm
	if [[ "$confirm" =~ ^[Yy]$ ]]; then
		cp -R "$src/". "$dst/"
		echo "Copy completed."
	else
		echo "Cancelled."
	fi
}
