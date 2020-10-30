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

# prepare SOURCES/tar.gz for RPM
# FIXME: we expect that parent directory is "pil-git-scripts" !
(cd .. && tar cvzf pil-git-scripts/build/rpm-suse/rpmbuild/SOURCES/pil-git-scripts.tar.gz \
	pil-git-scripts/README.md pil-git-scripts/ChangeLog \
        pil-git-scripts/LICENSE pil-git-scripts/scripts )

rpmbuild -bb \
	-D'_topdir '`pwd`/build/rpm-suse/rpmbuild \
	-D'_tmppath '`pwd`/build/rpm-suse/rpmbuild/tmp \
       	pil-git-scripts.spec
exit 0

