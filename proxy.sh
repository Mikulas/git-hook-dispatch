#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

STDIN="$(cat)"

for HANDLER in \
        "$DIR/hooks/$HOOK_NAME.d"/* \
        "$GIT_DIR/hooks/$HOOK_NAME.d"/* \
        "$GIT_DIR/hooks/$HOOK_NAME" \
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
