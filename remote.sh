#!/bin/bash
set -ueo pipefail

DEFAULT_CONFIGS="vim tmux fish git"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

BRANCH=${BRANCH:-"master"}

cd ${HOME}
git clone -b ${BRANCH} git@github.com:azarashi2931/dotfiles.git
cd dotfiles
stow -v --no-folding ${CONFIGS}
