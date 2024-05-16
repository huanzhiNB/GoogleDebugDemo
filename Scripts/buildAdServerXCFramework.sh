# Create directories for output
mkdir -p "$PWD/output/xcframeworkAdServer"

echo -e "\n\n${GREEN}INSTALL PODS${NC}\n\n"

#gem install cocoapods --user-install
pod install --repo-update

echo -e "\n\n${GREEN}BUILD ADAPTERS${NC}\n\n"

# Build for simulator and device architectures
xcodebuild archive \
    -workspace GoogleDebugDemo.xcworkspace \
    -scheme "AdServerDebugSdk" \
    -destination="iOS" \
    -archivePath "$PWD/output/xcframeworkAdServer/AdServerDebugSdk-iOS" \
    SKIP_INSTALL=NO \
    -configuration Release \
    -arch arm64 \
    -sdk "iphoneos" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -workspace GoogleDebugDemo.xcworkspace \
    -scheme "AdServerDebugSdk" \
    -destination="iOS Simulator" \
    -archivePath "$PWD/output/xcframeworkAdServer/AdServerDebugSdk-Simulator" \
    SKIP_INSTALL=NO \
    -configuration Release \
    -arch x86_64 \
    -sdk "iphonesimulator" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create xcframework
xcodebuild -create-xcframework \
    -framework "$PWD/output/xcframeworkAdServer/AdServerDebugSdk-iOS.xcarchive/Products/Library/Frameworks/AdServerDebugSdk.framework" \
    -framework "$PWD/output/xcframeworkAdServer/AdServerDebugSdk-Simulator.xcarchive/Products/Library/Frameworks/AdServerDebugSdk.framework" \
    -output "$PWD/output/xcframeworkAdServer/AdServerDebugSdk.xcframework"
