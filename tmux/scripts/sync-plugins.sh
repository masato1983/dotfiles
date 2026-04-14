#!/usr/bin/env bash
set -euo pipefail

plugin_root="${TMUX_PLUGIN_MANAGER_PATH:-$HOME/.tmux/plugins}"
tpm_dir="${plugin_root}/tpm"
navigator_dir="${plugin_root}/vim-tmux-navigator"
navigator_remote="https://github.com/christoomey/vim-tmux-navigator.git"

ensure_tpm() {
	if [ -d "${tpm_dir}/.git" ]; then
		return
	fi

	git clone https://github.com/tmux-plugins/tpm "${tpm_dir}"
}

normalize_navigator_remote() {
	if [ ! -d "${navigator_dir}/.git" ]; then
		return
	fi

	current_remote="$(git -C "${navigator_dir}" remote get-url origin)"
	if [ "${current_remote}" != "${navigator_remote}" ]; then
		git -C "${navigator_dir}" remote set-url origin "${navigator_remote}"
	fi
}

sync_plugins() {
	"${tpm_dir}/bin/install_plugins"
	normalize_navigator_remote
	"${tpm_dir}/bin/update_plugins" vim-tmux-navigator
}

reload_tmux() {
	if ! command -v tmux >/dev/null 2>&1; then
		return
	fi

	if tmux display-message -p '#{session_name}' >/dev/null 2>&1; then
		tmux source-file "${HOME}/.tmux.conf"
	fi
}

print_versions() {
	if [ -d "${navigator_dir}/.git" ]; then
		printf 'vim-tmux-navigator %s\n' "$(git -C "${navigator_dir}" rev-parse --short HEAD)"
	fi
}

main() {
	ensure_tpm
	sync_plugins
	reload_tmux
	print_versions
}

main "$@"
