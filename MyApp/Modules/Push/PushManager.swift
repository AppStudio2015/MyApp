//
//  PushManager.swift
//  MyApp
//
//  Created by Qufei on 2018/11/26.
//  Copyright © 2018 Carbar. All rights reserved.
//

import UIKit

fileprivate let pushKey: String = ""

class PushManager: NSObject {
    
    static let sharedInstance: PushManager = {
        let instance = PushManager()
        return instance
    }()
    
    public func register() -> Void {
//        let entity = JPUSHRegisterEntity.init()
//        if #available(iOS 12.0, *) {
//            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
//        } else {
//            // Fallback on earlier versions
//        }
//
//        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
//
//        JPUSHService.setup(withOption: <#T##[AnyHashable : Any]!#>, appKey: <#T##String!#>, channel: <#T##String!#>, apsForProduction: <#T##Bool#>)
//
    }
}
