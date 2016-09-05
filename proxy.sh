#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

STDIN=""
if [ ! -t 0 ]; then
        STDIN="$(cat)"
fi

# GIT_DIR is not set when git command is called from REPO_ROOT
REPO_ROOT="$(git rev-parse --show-toplevel)"
REPO_ROOT="${GIT_DIR:-$REPO_ROOT}"

for HANDLER in \
        "$DIR/hooks/$HOOK_NAME.d"/* \
        "$REPO_ROOT/hooks/$HOOK_NAME.d"/* \
        "$REPO_ROOT/hooks/$HOOK_NAME" \
; do
        if [[ ! -f "$HANDLER" ]]; then
                continue
        fi
        if [[ ! -x "$HANDLER" ]]; then
                echo "error: $HANDLER hook is not executable"
                exit 1
        fi
        echo "$HANDLER"
        echo "$STDIN" | "$HANDLER" "${@:2}"
done
