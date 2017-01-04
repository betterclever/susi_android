#!/bin/sh
set -e

echo $CIRCLE_BRANCH

if [[ $CIRCLE_BRANCH != "pull*" ]]
then
	git config --global user.name "betterclever"
	git config --global user.email "paliwal.pranjal83@gmail.com"

	echo "hi"
	git clone --quiet --branch=apk https://betterclever:$GITHUB_KEY@github.com/betterclever/susi_android apk > /dev/null
	ls
	cp -r ${HOME}/${CIRCLE_PROJECT_REPONAME}/app/build/outputs/apk/app-debug.apk apk/susi-debug.apk
	cp -r ${HOME}/${CIRCLE_PROJECT_REPONAME}/app/build/outputs/apk/app-release-unsigned.apk apk/susi-release.apk
	cd apk

	git checkout --orphan workaround
	git add -A

	git commit -am "[Circle CI] Update Susi Apk"

	git branch -D apk
	git branch -m apk

	git push origin apk --force --quiet > /dev/null
else
	echo "In Else"
fi
