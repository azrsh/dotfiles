#!/bin/bash
set -euo pipefail

# Entrypoint for codespaces

DEFAULT_CONFIGS="vim tmux fish git"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}
script/install.sh ${CONFIGS}
