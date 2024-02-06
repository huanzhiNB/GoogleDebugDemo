//
//  AdServerInitializer.swift
//  AdServerDebugSdk
//
//  Created by Huanzhi Zhang on 2/5/24.
//

import Foundation
import PrebidMobile

public class AdServerInitializer: NSObject {
    public static func initializeAdServer() {
        Prebid.shared.shareGeoLocation = true
        //Prebid.shared.timeoutMillis = 1000;
        do {
            try Prebid.shared.setCustomPrebidServer(url: "https://prebid-server.newsbreak.com/openrtb2/auction")
            Prebid.shared.prebidServerAccountId = "sggU8Y1UB6xara62G23qGdcOA8co2O4N_debug"
            Prebid.shared.shareGeoLocation = true
            Prebid.initializeSDK()
        } catch {
            
        }
    }
}

