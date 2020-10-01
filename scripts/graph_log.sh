#!/bin/bash
set -x
exec git log --graph --all --decorate --oneline
exit 1
