//
//  ViewController.swift
//  GoogleDebugApp
//
//  Created by Huanzhi Zhang on 1/23/24.
//

import UIKit
import GoogleDebugSdk
import AdServerDebugSdk

class ViewController: UIViewController, GoogleQueryInfoListener, AdRequestLoaderDelegate {
    
    
    @IBOutlet var appBannerView: UIView!
    
    private var adRequestLoader: AdRequestLoader?
    private var gadBannerLoader: GADBannerLoader?
    private var googleQueryInfoFetcher: GoogleQueryInfoFetcher?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adRequestLoader = AdRequestLoader()
        googleQueryInfoFetcher = GoogleQueryInfoFetcher()
        gadBannerLoader = GADBannerLoader()
        gadBannerLoader?.rootViewController = self
        
        // test with S2S load ad banner
        // fetch query info -> send request to ad server -> send request to Google with ad Sring
        googleQueryInfoFetcher?.fetch(completeListener: self)
        
        // uncomment next call to test with client to server banner
        /*
        gadBannerLoader?.loadC2SBannerView(adUnitId: "ca-app-pub-3940256099942544/2934735716") { bannerView in
            if let bannerView = bannerView {
                self.appBannerView.addSubview(bannerView)
            }
        }
         */
        
    }
    
    func didReceiveResponse(adString: String, adUnitId: String) {
        DispatchQueue.main.async {
            self.gadBannerLoader?.loadS2SBannerView(adString: adString, adUnitId: adUnitId) { bannerView in
                if let bannerView = bannerView {
                    self.appBannerView.addSubview(bannerView)
                }
            }
        }
    }
    
    func didFailToReceiveResponse(errorMessage: String) {
        print("demo error: \(errorMessage)")
    }
    
    func onComplete(queryInfoString: String) {
        self.adRequestLoader?.loadRequest(queryInfoString: queryInfoString, delegate: self)
    }

}

