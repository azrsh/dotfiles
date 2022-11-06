#!/bin/bash
set -euo pipefail

CONFIGS=${@}

script/uninstall.sh ${CONFIGS}

git pull origin "$(git branch --show-current)"
git submodule foreach git reset --hard HEAD # Discard local changes
git submodule update

script/install.sh ${CONFIGS}
