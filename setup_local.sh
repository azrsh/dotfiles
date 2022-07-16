#!/bin/bash
set -uex

DEFAULT_CONFIGS="vim tmux fish"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

stow -v ${CONFIGS}
