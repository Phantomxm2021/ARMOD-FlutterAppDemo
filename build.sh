#!/bin/bash
# realease docs https://docs.flutter.dev/deployment/android
export JAVA_HOME='/Applications/Unity/Hub/Editor/2021.3.13f1/PlaybackEngines/AndroidPlayer/OpenJDK' 
# flutter config --android-sdk='/Applications/Unity/Hub/Editor/2021.3.13f1/PlaybackEngines/AndroidPlayer/SDK'
if [$1]
then
    echo "Debug build start..."
    flutter run -d 5XAECU5H5HKNMBU8
else
    echo "Release build start..."
    flutter build apk --split-per-abi --release
fi
echo "Build Success"