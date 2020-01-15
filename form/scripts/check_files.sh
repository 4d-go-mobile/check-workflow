#!/bin/bash

checkUrl="https://raw.githubusercontent.com/4d-for-ios/check-workflow/master"

echo "check SwiftPM"
if [ ! -f "Package.swift" ]; then
  curl -L $checkUrl/form/files/Package.swift --output Package.swift
  echo "⚠️ Edit Package.swift file to change the Package name"
fi

echo "check workflows"
mkdir -p .github/workflows/

if [ ! -f ".github/workflows/check.yml" ]; then
  curl -L $checkUrl/form/workflows/check.yml --output .github/workflows/check.yml
fi
if [ ! -f ".github/workflows/release.yml" ]; then
  curl -L $checkUrl/form/workflows/release.yml --output .github/workflows/release.yml
fi

echo "check quality configuration files"
if [ ! -f ".swiftlint.yml" ]; then
  curl -L $checkUrl/form/quality/.swiftlint.yml --output .swiftlint.yml
fi
if [ ! -f ".iblinter.yml" ]; then
  curl -L $checkUrl/form/quality/.iblinter.yml --output .iblinter.yml
fi