#!/bin/bash

set -e
set -o pipefail
cd `dirname $0`
rm -fv pil-git-scripts*.deb

err=`mktemp`
trap "rm -f $err" RETURN
parsechangelog ChangeLog 2> $err
if [ -s "$err" ]; then
	echo "There were errors/warnings parsing ChangeLog:" >&2
	cat "$err" >&2
	exit 1
fi

equivs-build pil-git-scripts.cfg
exit 0

