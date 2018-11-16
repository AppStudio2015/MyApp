//
//  UserDefaultManager.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/3.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit
import Foundation

public enum StoreType: Int {
    case int
    case string
    case bool
    case timestamp
    case ulong
    case long
    case object
}

final class UserDefaultManager: NSObject {

    // MARK: - Public Properties
    let StoreKeyAppVersion: String = "StoreKeyAppVersion"
    let StoreKeyUserId: String     = "StoreKeyUserId"
    let StoreKeyUserName: String   = "StoreKeyUserName"
    
    // MARK: - Private Properties
    
    // MARK: - Setters and Getters
    
    // MARK: - Public Functions
    
    public class func storeValue(_ value: Any, forKey key: String, type: StoreType) -> Void {
        let userDefaults = UserDefaults.standard
        var aValue: Any? = nil
        
        switch type {
        case .int:
            aValue = NSNumber.init(value: value as! Int)
            break
        case .bool:
            aValue = NSNumber.init(value: value as! Bool)
            break
        case .string:
            aValue = value as! String
            break
        default:
            return
        }
        userDefaults.set(aValue, forKey: key)
//        userDefaults.synchronize()
    }
    
    public class func storeValue(forKey key: String, type: StoreType) -> Any? {
        let userDefaults = UserDefaults.standard
        var value: Any? = nil
        switch type {
        case .int:
            if let aValue = userDefaults.value(forKey: key) as? NSNumber {
                value = aValue.intValue
            }
            break
        case .bool:
            if let aValue = userDefaults.value(forKey: key) as? NSNumber {
                value = aValue.boolValue
            }
            break
        case .string:
            if let aValue = userDefaults.value(forKey: key) as? String {
                value = aValue
            }
            break
        default:
            break
        }
        
        return value
    }
    
    public class func didStore() -> Bool {
        return UserDefaults.standard.synchronize()
    }
    
    // MARK: - Private Functions
    
}
