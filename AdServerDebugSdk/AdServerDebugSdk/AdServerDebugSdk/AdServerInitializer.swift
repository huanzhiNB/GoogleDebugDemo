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
            try Prebid.shared.setCustomPrebidServer(url: "yourServer.com")
            Prebid.shared.prebidServerAccountId = "yourId"
            Prebid.shared.shareGeoLocation = true
            Prebid.initializeSDK()
        } catch {
            
        }
    }
}

