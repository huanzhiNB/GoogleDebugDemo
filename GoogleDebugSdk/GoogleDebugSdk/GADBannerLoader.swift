//
//  GADBannerLoader.swift
//  GoogleDebugSdk
//
//  Created by Huanzhi Zhang on 2/5/24.
//

import Foundation
import GoogleMobileAds

public class GADBannerLoader: NSObject {
    public typealias BannerAdFetchCompletion = (UIView?) -> Void
    
    public var gadBannerView: GAMBannerView?
    public var rootViewController: UIViewController?
    public var completionHandler: BannerAdFetchCompletion?
    
    public func loadS2SBannerView(adString: String, adUnitId: String, completionHandler: @escaping BannerAdFetchCompletion) {
        // load server to server ad view
        self.completionHandler = completionHandler
        let gadBannerView = GAMBannerView(adSize: GADAdSizeBanner)
        self.gadBannerView = gadBannerView
        gadBannerView.isAutoloadEnabled = false
        let request = GAMRequest()
        request.adString = adString
        gadBannerView.adUnitID = adUnitId
        gadBannerView.delegate = self
        if let rootViewController = self.rootViewController {
            gadBannerView.rootViewController = rootViewController
        } else {
            print("demo error: rootViewController is nill")
        }
        gadBannerView.load(request)
    }
    
    public func loadC2SBannerView(adUnitId: String, completionHandler: @escaping BannerAdFetchCompletion) {
        // load client to server ad view
        self.completionHandler = completionHandler
        let gadBannerView = GAMBannerView(adSize: GADAdSizeBanner)
        self.gadBannerView = gadBannerView
        gadBannerView.adUnitID = adUnitId
        if let rootViewController = self.rootViewController {
            gadBannerView.rootViewController = rootViewController
        } else {
            print("demo error: rootViewController is nill")
        }
        gadBannerView.delegate = self
        gadBannerView.load(GADRequest())
    }
}

extension GADBannerLoader : GADBannerViewDelegate {
    public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        if let completionHandler = self.completionHandler {
            completionHandler(bannerView)
        }
    }
    
    public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("demo error: \(error.localizedDescription)")
    }
}
