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

checkUrl="https://raw.githubusercontent.com/4d-for-ios/check-workflow"

echo "check SwiftPM"
if [ ! -f "Package.swift" ]; then
  curl -L $checkUrl/master/form/files/Package.swift --output Package.swift
fi

echo "check workflows"
mkdir -p .github/workflows/

if [ ! -f ".github/workflows/check.yml" ]; then
  curl -L $checkUrl/master/form/workflows/check.yml --output .github/workflows/check.yml
fi
if [ ! -f ".github/workflows/release.yml" ]; then
  curl -L $checkUrl/master/form/workflows/release.yml --output .github/workflows/release.yml
fi

echo "check quality configuration files"
if [ ! -f ".swiftlint.yml" ]; then
  curl -L $checkUrl/master/form/quality/.swiftlint.yml --output .swiftlint.yml
fi
if [ ! -f ".iblinter.yml" ]; then
  curl -L $checkUrl/master/form/quality/.iblinter.yml --output .iblinter.yml
fi

git add .
git diff --quiet && git diff --staged --quiet || git commit -a -m "Add mandatory files"

# create PR ? https://github.com/peter-evans/create-pull-request