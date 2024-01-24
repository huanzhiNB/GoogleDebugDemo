//
//  ViewController.swift
//  GoogleDebugApp
//
//  Created by Huanzhi Zhang on 1/23/24.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet var appBannerView: UIView!
    
    private var gadBannerView: GADBannerView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gadBannerView = GAMBannerView(adSize: GADAdSizeBanner)
        gadBannerView?.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        gadBannerView?.rootViewController = self
        gadBannerView?.delegate = self
        gadBannerView?.load(GADRequest())
        
        
    }
    
    
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
        appBannerView.addSubview(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
}

