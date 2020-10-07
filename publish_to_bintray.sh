#!/bin/bash

# this script uploads *.deb packages from this directory to BinTray

set -e
cd `dirname $0`

BINTRAY_REPO=${BINTRAY_REPO:-pil-packages}
BINTRAY_PKG=${BINTRAY_PKG:-pil-git-scripts}
BINTRAY_DIST=${BINTRAY_DIST:-buster}
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

for i in *.deb
do
curl -T $i -fsS --netrc-file $BINTRAY_CURL_FILE \
	https://api.bintray.com/content/$BINTRAY_LOGIN/$BINTRAY_REPO\
/$BINTRAY_PKG/0/$i\;deb_distribution=$BINTRAY_DIST\;\
deb_component=main\;deb_architecture=all
done
