#!/bin/bash
set -euCo pipefail

# This script can be an entrypoint for codespaces

cd mitamae
bin/setup
case "$(uname)" in
  "Darwin")  bin/mitamae local $@ roles/darwin/default.rb ;;
  "Linux")  bin/mitamae local $@ roles/linux/default.rb ;;
  *) echo "unsupproted platform: $(uname)"; exit 1 ;;
esac
