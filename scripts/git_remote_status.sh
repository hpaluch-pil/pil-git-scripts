#!/bin/bash
set -xe
exec git fetch --dry-run
exit 1

