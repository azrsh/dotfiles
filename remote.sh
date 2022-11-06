#!/bin/bash
set -ueo pipefail

DEFAULT_CONFIGS="vim tmux fish git"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

BRANCH=${BRANCH:-"master"}

cd ${HOME}
git clone --recursive -b ${BRANCH} https://github.com/azarashi2931/dotfiles.git
cd dotfiles

stow -v --no-folding -d ./config -t ${HOME} ${DEFAULT_CONFIGS}

mkdir -p ./bin
stow -v --no-folding -d ./tool -t ./bin $(find ./tool/* -type d -exec basename {} \;)
echo "Please add '$(pwd)/bin' to \$PATH"
