#!/bin/bash
set -uex

DEFAULT_CONFIGS="vim tmux fish"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

BRANCH=${BRANCH:-"master"}

cd ${HOME}
git clone -b ${BRANCH} git@github.com:azarashi2931/dotfiles.git
cd dotfiles
bash setup_local.sh $CONFIGS
