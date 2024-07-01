#!/bin/bash

set -eu

bin/setup

# Homebrew does not allow sudo.
case "$(uname)" in
  "Darwin")  bin/mitamae local $@ roles/darwin/default.rb ;;
  *) exit 1 ;;
esac
