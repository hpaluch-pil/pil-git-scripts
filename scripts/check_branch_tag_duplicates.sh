#!/bin/bash
# check for duplicate references - when branch name is same as tag name
# This causes serious issues to GitLab
# - https://gitlab.com/gitlab-org/gitlab/-/issues/238438
# - https://gitlab.com/gitlab-org/gitlab/-/issues/219583 
set -e
set -o pipefail

cnt=0
rc=0
declare -A tag_names

for t in $(git tag -l)
do
	tag_names["$t"]=1
done

for b in $(git branch -a | sed 's@.*/@@g')
do
	[ -z ${tag_names["$b"]} ] || {
		echo "Tag name '$b' is also branch name '$b'"
		rc=1
		(( cnt+=1 ))
	}
done
if [ "$rc" -eq 0 ]; then
	echo "OK - no duplicate tag-branch names"
else
	echo
	echo "WARNING: found $cnt duplicate tag-branch names."
        echo "         It may cause serious problems to GitLab"
	echo
	echo "         Please follow these links for details:"
	echo "         - https://gitlab.com/gitlab-org/gitlab/-/issues/238438"
	echo "         - https://gitlab.com/gitlab-org/gitlab/-/issues/219583"
	echo
fi
exit $rc

