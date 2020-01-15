#!/bin/bash

checkUrl="https://raw.githubusercontent.com/4d-for-ios/check-workflow"

echo "check workflows"
mkdir -p .github/workflows/

if [ ! -f ".github/workflows/check.yml" ]; then
  curl -L $checkUrl/master/formatter/workflows/check.yml --output .github/workflows/check.yml
fi
if [ ! -f ".github/workflows/release.yml" ]; then
  curl -L $checkUrl/master/formatter/workflows/release.yml --output .github/workflows/release.yml
fi