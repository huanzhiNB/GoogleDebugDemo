//
//  AdRequestLoader.swift
//  AdServerDebugSdk
//
//  Created by Huanzhi Zhang on 2/5/24.
//

import Foundation
import PrebidMobile

public class AdRequestLoader: NSObject {
    var bidRequester: PBMBidRequester?
    var configId: String?
    var delegate: AdRequestLoaderDelegate?
    
    public func loadRequest(queryInfoString: String, delegate: AdRequestLoaderDelegate) {
        var adUnitConfig = multiFormatAdUnitConfig(configId:  "msp-android-article-top-display_gg",
                                                   gadQueryInfo: queryInfoString,
                                                   requestUUID: "12345678",
                                                   prebidBannerAdSize: CGSize(width: 320, height: 50))
        
        let bidRequester = PBMBidRequester(connection: ServerConnection.shared,
                                           sdkConfiguration: Prebid.shared,
                                           targeting: Targeting.shared,
                                           adUnitConfiguration: adUnitConfig)
        self.bidRequester = bidRequester
        
        bidRequester.requestBids { [weak self] bidResponse, error in
            guard let self = self else { return }

            if let error = error {
                print("demo error:" + error.localizedDescription)
                return
            }
            
            if let bidResponse = bidResponse,
               let adString = bidResponse.winningBid?.bid.adm,
               let rawBidDict = SafeAs(bidResponse.winningBid?.bid.rawJsonDictionary, [String: Any].self),
               let bidExtDict = SafeAs(rawBidDict["ext"], [String: Any].self),
               let googleExtDict = SafeAs(bidExtDict["google"], [String: Any].self),
               let adUnitId = SafeAs(googleExtDict["ad_unit_id"], String.self) {
                self.delegate?.didReceiveResponse(adString: adString, adUnitId: adUnitId)
            } else {
                print("demo error: invalid ad response")
            }
        }
    }
    
    public func multiFormatAdUnitConfig(configId: String,
                                        gadQueryInfo: String,
                                        requestUUID: String,
                                        prebidBannerAdSize: CGSize) -> AdUnitConfig {
        let adUnitConfig = AdUnitConfig(configId: configId, size: prebidBannerAdSize)
        adUnitConfig.adConfiguration.bannerParameters.api = PrebidConstants.supportedRenderingBannerAPISignals
        adUnitConfig.nativeAdConfiguration = NativeAdConfiguration()
        adUnitConfig.adFormats = [.display, .native]
        
        adUnitConfig.addContextData(key: "query_info", value: gadQueryInfo)
        var assets = [NativeAsset]()
        assets.append(NativeAssetTitle(length: 100, required: true))
        adUnitConfig.nativeAdConfiguration?.markupRequestObject.assets = assets
        
        return adUnitConfig
    }
    
    public func SafeAs<T, U>(_ object: T?, _ objectType: U.Type) -> U? {
        if let object = object {
            if let temp = object as? U {
                return temp
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

public protocol AdRequestLoaderDelegate: AnyObject {
    func didReceiveResponse(adString: String, adUnitId: String)

    func didFailToReceiveResponse(errorMessage: String)
}
