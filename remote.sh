#!/bin/bash
set -ueo pipefail

DEFAULT_CONFIGS="vim tmux fish"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

cd ${HOME}
git clone https://github.com/azarashi2931/dotfiles.git
cd dotfiles
stow -v --no-folding ${CONFIGS}
