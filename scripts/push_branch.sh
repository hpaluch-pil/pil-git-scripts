#!/bin/bash

set -o pipefail
branch=''
if [ $# -eq 1 ]; then
	branch="$1"
else
	branch=`git branch | awk '/^\*/ { print $2 }'`
	[ -n "$branch" ] || {
		echo "No branch argument specified and unable to detect git branch"
		exit 1
	}
fi

set -xe
exec git push -u --tags origin "$branch"
exit 1

