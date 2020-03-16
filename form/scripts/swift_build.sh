#!/usr/bin/sh

checkUrl=$RELEASE_REPO # env var

if [ ! -f "Package.swift" ]; then
  echo "⚠️ No Package.swift. Default one will be used to build."
  echo "💡 Create your own file if you defined specific dependencies."
  echo "You could find a default template at url $checkUrl/form/files/Package.swift"
  curl -L $checkUrl/form/files/Package.swift --output Package.swift
fi

sdk=`xcrun -sdk iphonesimulator -show-sdk-path`
sdkVersion=`echo $sdk | sed -E 's/.*iPhoneSimulator(.*)\.sdk/\1/'`
swift build  -Xswiftc "-sdk" -Xswiftc "$sdk" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios$sdkVersion-simulator"
if [ $? -ne 0 ]; then
  echo "Failed to compile" >&2
  exit 1
fi

# check external SDK version
curl -fsSL $checkUrl/form/scripts/check_sdk_version.sh | bash -s 5.1.3
