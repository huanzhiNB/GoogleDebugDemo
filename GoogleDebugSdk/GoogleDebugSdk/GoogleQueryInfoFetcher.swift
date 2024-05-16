//
//  GoogleQueryInfoFetcher.swift
//  GoogleDebugSdk
//
//  Created by Huanzhi Zhang on 2/5/24.
//

import Foundation
import GoogleMobileAds

public class GoogleQueryInfoFetcher: NSObject {
    
    public func fetch(completeListener: GoogleQueryInfoListener) {
        let request = GAMRequest()
        // Specify the "query_info_type" as "requester_type_8" to
        // denote that the usage of QueryInfo is for Ad Manager S2S.
        let extras = GADExtras()
        extras.additionalParameters = ["query_info_type" : "requester_type_8"]
        request.register(extras)
        let googleAdFormat = GADAdFormat.banner
        GADQueryInfo.createQueryInfo(with: request, adFormat: googleAdFormat) { [weak self] queryInfo, error in
            guard let self = self else {return}
            if let error = error {
                print("demo error: \(error.localizedDescription)")
                return
            }

            if let queryInfoString = queryInfo?.query {
                completeListener.onComplete(queryInfoString: queryInfoString)
            } else {
                print("demo error: fail to receive queryInfo")
            }
        }
    }
}

public protocol GoogleQueryInfoListener: AnyObject {
    func onComplete(queryInfoString: String)
}
