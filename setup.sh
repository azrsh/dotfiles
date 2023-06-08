#!/bin/bash
set -euo pipefail

# Entrypoint for codespaces

DEFAULT_CONFIGS="vim tmux git"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}
script/azdot-install ${CONFIGS}
