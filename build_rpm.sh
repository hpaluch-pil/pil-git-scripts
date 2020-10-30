#!/bin/bash

set -e
set -o pipefail
cd `dirname $0`
source /etc/os-release
rm -rf build/rpm-suse
[ -n "$ID" ] || {
	echo "Unable to extract ID from /etc/os-release" >&2
	exit 1
}
mkdir -p build/rpm-$ID
for i in BUILD RPMS SOURCES SPECS SRPMS tmp
do
       	mkdir -p build/rpm-$ID/rpmbuild/$i
done

# prepare SOURCES/tar.gz for RPM
mkdir -p build/rpm-$ID/tree/pil-git-scripts
cp README.md ChangeLog LICENSE build/rpm-$ID/tree/pil-git-scripts
cp -r scripts build/rpm-$ID/tree/pil-git-scripts
( cd build/rpm-$ID/tree && tar cvzf ../rpmbuild/SOURCES/pil-git-scripts.tar.gz \
        pil-git-scripts/ )

rpmbuild -bb \
	-D'_topdir '`pwd`/build/rpm-$ID/rpmbuild \
	-D'_tmppath '`pwd`/build/rpm-$ID/rpmbuild/tmp \
       	pil-git-scripts.spec
exit 0

