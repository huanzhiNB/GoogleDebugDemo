Steps to reproduce the S2S issue: 
  1. go to the directory of the workspace
  2. run "Scripts/buildXCFramework.sh" command to build the demo sdk
  3. find the GoogleDebugSdk.xcframework under path: /output/xcframework/
  4. introduce the .xcframework to your app
  5. testing load ad again, you don't need to do any code change.

Steps to reroduce the C2S issue:
  1. run the GoogleDebugApp in your Xcode, and monitor the error log begins with "bannerView:didFailToReceiveAdWithError:". The sdk has been introduced and you don't need to do any code change to see the error.
  2. To fix the load error, uncomment GADInitializer.initializeGAD() in AppDelegate file in GoogleDebugApp, run the app again, now you should see the ad view after launch.
