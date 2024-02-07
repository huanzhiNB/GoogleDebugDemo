Steps to reproduce the S2S issue: 
  1. Select GoogleDebugApp as build target in your xcode
  2. Launch app on your device/simulator
  3. Search "demo error" in the console output to see the error message

Steps to test with S2S banner:
  1. Go to ViewController.swift in the GoogleDebugApp project
  2. comment:
       googleQueryInfoFetcher?.fetch(completeListener: self)
     line to disable S2S load ad
  3. uncomment:
       gadBannerLoader?.loadC2SBannerView(...
     line to enable client to server load ads
  4. Select GoogleDebugApp as build target in your xcode
  5. Launch app on your device/simulator, you should be able to see the banner ad display.
     
