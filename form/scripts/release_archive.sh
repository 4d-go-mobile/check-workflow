#!/usr/bin/sh

GITHUB_EVENT_PATH=$1
REPOSITORY_NAME=$(jq --raw-output '.repository.name' $GITHUB_EVENT_PATH)
zip -r $REPOSITORY_NAME.zip .  -x ".*" -x "__MACOSX"
