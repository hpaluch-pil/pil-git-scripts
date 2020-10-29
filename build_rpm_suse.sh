#!/bin/bash

set -e
set -o pipefail
cd `dirname $0`
rm -rf build/rpm-suse
mkdir -p build/rpm-suse
for i in BUILD RPMS SOURCES SPECS SRPMS tmp
do
       	mkdir -p build/rpm-suse/rpmbuild/$i
done
cp scripts/*.sh build/rpm-suse/rpmbuild/SOURCES/

rpmbuild -bb \
	-D'_topdir '`pwd`/build/rpm-suse/rpmbuild \
	-D'_tmppath '`pwd`/build/rpm-suse/rpmbuild/tmp \
       	pil-git-scripts.spec
exit 0

