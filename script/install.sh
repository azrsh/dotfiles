#!/bin/bash
set -euo pipefail

CONFIGS=${@}

function config() {
  stow -v --no-folding -d ./config -t ${HOME} ${CONFIGS}
}

function tool() {
  mkdir -p ./bin
  stow -v --no-folding -d ./tool -t ./bin $(find ./tool/* -type d -exec basename {} \;)

  local binaries="$(find ./bin/* -type l)"
  if [ -n "${binaries}" ]; then
    chmod +x $binaries
  fi
  echo "Please add '$(pwd)/bin' to \$PATH"
}

config
tool
