#!/bin/bash

set -e
set -o pipefail

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

echo "Source ready in build/rpm-$ID/tree/"
cat <<EOF
You can now create src.rpm using command like:
  mock -r epel-7-x86_64 --buildsrpm --spec pil-git-scripts.spec --sources build/rpm-debian/rpmbuild/SOURCES
And use it to build binary RPM:
  mock -r epel-7-x86_64 --rebuild /var/lib/mock/epel-7-x86_64/result/pil-git-scripts-0.12-0.src.rpm 
EOF

exit 0

