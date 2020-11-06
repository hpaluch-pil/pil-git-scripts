#!/bin/bash

set -e
set -o pipefail

usage () {
	echo "Usage: $0 [ all|binary|source ]" >&2
	echo " where: " >&2
	echo "   all (default) - build both binary and source rpm" >&2
	echo "   binary        - build only binary rpm" >&2
	echo "   source        - build both binary and source rpm" >&2
	exit 1
}

declare -A build_args
build_args["all"]=-ba
build_args["binary"]=-bb
build_args["source"]=-bs

build_type=all
[ $# -lt 2 ] || usage

[ $# -eq 0 ] || build_type="$1"
# remove any slashes
build_type=${build_type//-/}

# it is weird but these nested quotes really work...
[ -n "${build_args["$build_type"]}" ]  || {
	echo "ERROR: Invalid build type '$build_type'" >&2
	echo 
	usage
}

cd `dirname $0`
source /etc/os-release
rm -rf build/rpm-$ID
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
cp README.Debian build/rpm-$ID/tree/pil-git-scripts/README.txt
sed -n '/%changelog/,$p' pil-git-scripts.spec  | sed -n '2,$p' > build/rpm-$ID/tree/pil-git-scripts/ChangeLog
cp LICENSE build/rpm-$ID/tree/pil-git-scripts
cp -r scripts build/rpm-$ID/tree/pil-git-scripts
( cd build/rpm-$ID/tree && tar cvzf ../rpmbuild/SOURCES/pil-git-scripts.tar.gz \
        pil-git-scripts/ )

set -x
rpmbuild ${build_args["$build_type"]} \
	-D'_topdir '`pwd`/build/rpm-$ID/rpmbuild \
	-D'_tmppath '`pwd`/build/rpm-$ID/rpmbuild/tmp \
       	pil-git-scripts.spec
set +x
exit 0

