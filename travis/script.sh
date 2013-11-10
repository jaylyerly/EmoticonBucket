#!/bin/sh
set -e

xcodebuild -project EmoticonBucket/EmoticonBucket.xcodeproj -scheme EmoticonBucket clean
xcodebuild -project EmoticonBucket/EmoticonBucket.xcodeproj -scheme EmoticonBucket 
xcodebuild -project EmoticonBucket/EmoticonBucket.xcodeproj -scheme EmoticonBucket test
