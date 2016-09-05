#!/usr/bin/env bash
set -euxo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROXY_PATH="$DIR/proxies"
HOOKS_PATH="$DIR/hooks"

chmod a+x "$PROXY_PATH"/* "$HOOKS_PATH"/* "$HOOKS_PATH"/*.d/*
git config --global core.hooksPath "$PROXY_PATH"
