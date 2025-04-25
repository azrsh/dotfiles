#!/bin/bash

set -euCo pipefail

bin/setup
case "$(uname)" in
  "Darwin")  bin/mitamae local $@ roles/darwin/default.rb ;;
  "Linux")  bin/mitamae local $@ roles/linux/default.rb ;;
  *) echo "unsupproted platform: $(uname)"; exit 1 ;;
esac
