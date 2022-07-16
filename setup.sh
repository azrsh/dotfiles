#!/bin/bash
set -uex

DEFAULT_CONFIGS="vim tmux fish"
CONFIGS=${@:-"$DEFAULT_CONFIGS"}

cd ${HOME}
git clone git@github.com:azarashi2931/dotfiles.git
cd dotfiles
bash setup_local.sh $CONFIGS
