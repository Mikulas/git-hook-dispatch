#!/usr/bin/env bash
set -euxo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for HOOK in \
	applypatch-msg \
	pre-applypatch \
	post-applypatch \
	pre-commit \
	prepare-commit-msg \
	commit-msg \
	post-commit \
	pre-rebase \
	post-checkout \
	post-merge \
	pre-push \
	pre-receive \
	update \
	post-receive \
	post-update \
	push-to-checkout \
	pre-auto-gc \
	post-rewrite \
; do
	HOOK_DIR="$DIR/hooks/$HOOK.d"
	mkdir -p "$HOOK_DIR"
	touch "$HOOK_DIR/.gitkeep"

	sed "s/{{HOOK_NAME}}/$HOOK/g" "$DIR/proxy-template" > "$DIR/proxies/$HOOK"
done
