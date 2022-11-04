#!/bin/bash
set -ueo pipefail

DEFAULT_CONFIGS="vim tmux fish git"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

BRANCH=${BRANCH:-"master"}

cd ${HOME}
git clone -b ${BRANCH} https://github.com/azarashi2931/dotfiles.git
stow -v --no-folding -d ./dotfiles/config -t ${HOME} ${DEFAULT_CONFIGS}
