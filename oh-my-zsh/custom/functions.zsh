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
