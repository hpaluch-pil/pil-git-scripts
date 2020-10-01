#!/bin/bash

set -xe
set -o pipefail
cd `dirname $0`
equivs-build pil-git-scripts.cfg
exit 0

