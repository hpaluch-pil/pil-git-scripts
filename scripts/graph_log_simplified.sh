#!/bin/bash
set -x
# --simplify-by-decoration - from: https://stackoverflow.com/a/29737854
exec git log --graph --all --decorate --oneline --simplify-by-decoration
exit 1
