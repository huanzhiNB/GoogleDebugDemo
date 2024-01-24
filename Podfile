# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

workspace 'GoogleDebugDemo'

project 'GoogleDebugSdk/GoogleDebugSdk'

target 'GoogleDebugApp' do
  project 'GoogleDebugApp/GoogleDebugApp'
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for GoogleDebugSdk
  pod 'Google-Mobile-Ads-SDK', "10.14.0"

  #target 'GoogleDebugSdkTests' do
    # Pods for testing
  #end

end


target 'GoogleDebugSdk' do
  project 'GoogleDebugSdk/GoogleDebugSdk'
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for GoogleDebugSdk
  pod 'Google-Mobile-Ads-SDK', "10.14.0", :modular_headers => true

  #target 'GoogleDebugSdkTests' do
    # Pods for testing
  #end

end
