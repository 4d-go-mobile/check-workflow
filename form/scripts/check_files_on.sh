#!/bin/bash

if curl --head --silent --fail $1 2> /dev/null;
 then
  echo "Checking URL $1"
 else
  echo "The URL $1 is not accessible"
  exit 1
fi

echo "clone"
git clone $1 && cd "$(basename "$1" .git)"

echo "check"
currentDir=. # XXX must be computed
$currentDir/check_files.sh

echo "commit"
git add .
git diff --quiet && git diff --staged --quiet || git commit -a -m "Add mandatory files"

# create PR ? https://github.com/peter-evans/create-pull-request