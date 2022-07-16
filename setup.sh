#!/bin/bash
set -ueo pipefail

# Entrypoint for codespaces

DEFAULT_CONFIGS="vim tmux fish git"
stow -v --no-folding ${DEFAULT_CONFIGS}
