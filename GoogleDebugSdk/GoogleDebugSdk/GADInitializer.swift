//
//  GADInitializer.swift
//  GoogleDebugSdk
//
//  Created by Huanzhi Zhang on 1/30/24.
//

import Foundation
import GoogleMobileAds

public class GADInitializer: NSObject {
    public static func initializeGAD() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
}
