#!/bin/bash
set -euo pipefail

CONFIGS=${@}

script/uninstall.sh ${CONFIGS}

git pull origin HEAD
git submodule update

script/install.sh ${CONFIGS}
