#!/bin/bash

# this script uploads *.deb packages from this directory to BinTray

set -e
set -o pipefail
cd `dirname $0`

source /etc/os-release

BINTRAY_REPO=${BINTRAY_REPO:-pil-packages-rpms}
BINTRAY_PKG=${BINTRAY_PKG:-pil-git-scripts}
BINTRAY_DIST=${BINTRAY_DIST:-centos}
BINTRAY_CURL_FILE=${BINTRAY_CURL_FILE:-$HOME/.bintray-curl}
[ -r "$BINTRAY_CURL_FILE" ] || {
	{
		echo "curl netrc file '$BINTRAY_CURL_FILE' does not exist"
		echo "Please create file '$BINTRAY_CURL_FILE' with contents"
		echo "machine api.bintray.com login YOUR_BINTRAY_LOGIN password YOUR_BINTRAY_API_KEY"
	} >&2 
	exit 1
}
BINTRAY_LOGIN=$(fgrep 'machine api.bintray.com' $BINTRAY_CURL_FILE | awk '{print $4}')
[ -n "$BINTRAY_LOGIN" ] || {
	echo "Unable to extract BINTRAY_LOGIN from '$BINTRAY_CURL_FILE'" >&2
	exit 1
}

for i in build/rpm-$ID/rpmbuild/RPMS/noarch/pil-git-scripts-*.noarch.rpm
do
	name=$(basename "$i")
	set -x
curl -T $i -fsS --netrc-file $BINTRAY_CURL_FILE \
	https://api.bintray.com/content/$BINTRAY_LOGIN/$BINTRAY_REPO\
/$BINTRAY_PKG/0/$name
	set +x
	echo "Done. Remember to login to bintray, publish new version and un-publish old version of package"
done
exit 0

