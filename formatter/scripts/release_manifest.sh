#!/usr/bin/sh

GITHUB_REPOSITORY=$1
GITHUB_EVENT_PATH=$2

echo "Edit manifest to release and repository metadata"
GITHUB_URL="https://github.com/$GITHUB_REPOSITORY"

echo "➕ home page: $GITHUB_URL"
cat <<< "$(jq ".homepage = \"$GITHUB_URL\"" < manifest.json)" > manifest.json
REPOSITORY_NAME=$(jq --raw-output '.repository.name' $GITHUB_EVENT_PATH)
DOWNLOAD_URL="$GITHUB_URL/releases/latest/download/$REPOSITORY_NAME.zip"

echo "➕update url: $DOWNLOAD_URL"
cat <<< "$(jq ".updateURL = \"$DOWNLOAD_URL\"" < manifest.json)" > manifest.json
RELEASE_TAG=$(jq --raw-output '.release.tag_name' $GITHUB_EVENT_PATH)
echo "➕ tag: $RELEASE_TAG"
cat <<< "$(jq ".version = \"$RELEASE_TAG\"" < manifest.json)" > manifest.json

jq -s '.[0] * .[1]' manifest.json $GITHUB_EVENT_PATH > manifest.merged.json
rm manifest.json
mv manifest.merged.json manifest.json
