#!/bin/bash
set -euo pipefail

DEFAULT_CONFIGS="vim tmux git"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

BRANCH=${BRANCH:-"master"}

cd ${HOME}
git clone --recursive -b ${BRANCH} https://github.com/azrsh/dotfiles.git
cd dotfiles

script/azdot-install ${DEFAULT_CONFIGS}
