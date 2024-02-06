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
    
    //private var gadBannerView: GADBannerView? = nil
    //private var
    private var adRequestLoader: AdRequestLoader?
    private var gadBannerLoader: GADBannerLoader?
    private var googleQueryInfoFetcher: GoogleQueryInfoFetcher?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //gadBannerView = GAMBannerView(adSize: GADAdSizeBanner)
        //gadBannerView?.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        //gadBannerView?.rootViewController = self
        //gadBannerView?.delegate = self
        //gadBannerView?.load(GADRequest())
        adRequestLoader = AdRequestLoader()
        googleQueryInfoFetcher = GoogleQueryInfoFetcher()
        gadBannerLoader = GADBannerLoader()
        gadBannerLoader?.rootViewController = self
        googleQueryInfoFetcher?.fetch(completeListener: self)
        
    }
    
    func didReceiveResponse(adString: String, adUnitId: String) {
        DispatchQueue.main.async {
            self.gadBannerLoader?.loadBannerView(adString: adString, adUnitId: adUnitId) { bannerView in
                if let bannerView = bannerView {
                    self.appBannerView.addSubview(bannerView)
                }
            }
        }
    }
    
    func didFailToReceiveResponse(errorMessage: String) {
        
    }
    
    func onComplete(queryInfoString: String) {
        self.adRequestLoader?.loadRequest(queryInfoString: queryInfoString, delegate: self)
    }

}

