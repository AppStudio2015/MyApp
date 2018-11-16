//
//  UIDeviceExtension.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio. All rights reserved.

import UIKit

/// 设备类型枚举
@objc public enum DeviceModel: Int {
    case simulator        = 1000 //"simulator/sandbox"
    case iPod1            = 1010 //"iPod 1"
    case iPod2            = 1020 //"iPod 2"
    case iPod3            = 1030 //"iPod 3"
    case iPod4            = 1040 //"iPod 4"
    case iPod5            = 1050 //"iPod 5"
    case iPad2            = 2120 //"iPad 2"
    case iPad3            = 2130 //"iPad 3"
    case iPad4            = 2140 //"iPad 4"
    case iPhone4          = 3240 //"iPhone 4"
    case iPhone4S         = 3241 //"iPhone 4S"
    case iPhone5          = 3250 //"iPhone 5"
    case iPhone5S         = 3251 //"iPhone 5S"
    case iPhone5C         = 3252 //"iPhone 5C"
    case iPadMini1        = 2150 //"iPad Mini 1"
    case iPadMini2        = 2160 //"iPad Mini 2"
    case iPadMini3        = 2170 //"iPad Mini 3"
    case iPadAir1         = 2180 //"iPad Air 1"
    case iPadAir2         = 2181 //"iPad Air 2"
    case iPadPro9_7       = 2190 //"iPad Pro 9.7\""
    case iPadPro9_7_cell  = 2191 //"iPad Pro 9.7\" cellular"
    case iPadPro10_5      = 2210 //"iPad Pro 10.5\""
    case iPadPro10_5_cell = 2211 //"iPad Pro 10.5\" cellular"
    case iPadPro12_9      = 2220 //"iPad Pro 12.9\""
    case iPadPro12_9_cell = 2221 //"iPad Pro 12.9\" cellular"
    case iPhone6          = 3260 //"iPhone 6"
    case iPhone6plus      = 3261 //"iPhone 6 Plus"
    case iPhone6S         = 3262 //"iPhone 6S"
    case iPhone6Splus     = 3263 //"iPhone 6S Plus"
    case iPhoneSE         = 3264 //"iPhone SE"
    case iPhone7          = 3270 //"iPhone 7"
    case iPhone7plus      = 3271 //"iPhone 7 Plus"
    case iPhone8          = 3280 //"iPhone 8"
    case iPhone8plus      = 3281 //"iPhone 8 Plus"
    case iPhoneX          = 3210 //"iPhone X"
    case unrecognized     = 9999 //"?unrecognized?"
    
    func description() -> String {
        switch self {
        case .simulator:        return "simulator/sandbox"
        case .iPod1:            return "iPod 1"
        case .iPod2:            return "iPod 2"
        case .iPod3:            return "iPod 3"
        case .iPod4:            return "iPod 4"
        case .iPod5:            return "iPod 5"
        case .iPad2:            return "iPad 2"
        case .iPad3:            return "iPad 3"
        case .iPad4:            return "iPad 4"
        case .iPhone4:          return "iPhone 4"
        case .iPhone4S:         return "iPhone 4S"
        case .iPhone5:          return "iPhone 5"
        case .iPhone5S:         return "iPhone 5S"
        case .iPhone5C:         return "iPhone 5C"
        case .iPadMini1:        return "iPad Mini 1"
        case .iPadMini2:        return "iPad Mini 2"
        case .iPadMini3:        return "iPad Mini 3"
        case .iPadAir1:         return "iPad Air 1"
        case .iPadAir2:         return "iPad Air 2"
        case .iPadPro9_7:       return "iPad Pro 9.7\""
        case .iPadPro9_7_cell:  return "iPad Pro 9.7\" cellular"
        case .iPadPro10_5:      return "iPad Pro 10.5\""
        case .iPadPro10_5_cell: return "iPad Pro 10.5\" cellular"
        case .iPadPro12_9:      return "iPad Pro 12.9\""
        case .iPadPro12_9_cell: return "iPad Pro 12.9\" cellular"
        case .iPhone6:          return "iPhone 6"
        case .iPhone6plus:      return "iPhone 6 Plus"
        case .iPhone6S:         return "iPhone 6S"
        case .iPhone6Splus:     return "iPhone 6S Plus"
        case .iPhoneSE:         return "iPhone SE"
        case .iPhone7:          return "iPhone 7"
        case .iPhone7plus:      return "iPhone 7 Plus"
        case .iPhone8:          return "iPhone 8"
        case .iPhone8plus:      return "iPhone 8 Plus"
        case .iPhoneX:          return "iPhone X"
        case .unrecognized:     return "?unrecognized?"
        }
    }
}

extension UIDevice {
    
    // MARK: - Private Properties
    
    /// 判断当前设备是否为iPhone X
    @objc static internal private(set) var isX: Bool = {
        
        return UIScreen.maxSide() == 812
    }()
    
    // MARK: - Public Method
    
    /// 判断当前设备是否为iPhone X
    ///
    /// - Returns: YES：是；NO：不是。
    @objc func isX() -> Bool {
        return UIDevice.isX
    }
    
    /// 当前设备是否为iPad
    ///
    /// - Returns: YES：是；NO：不是。   
    @objc static internal private(set) var isPad: Bool = {
        return UIDevice.current.userInterfaceIdiom == .pad
    }()
    
    // MARK: - Public Properties
    
    /// 当前设备型号
    @objc static var deviceModel: DeviceModel {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
                
            }
        }
        var modelMap: [String : DeviceModel] = [
            "i386"       : .simulator,
            "x86_64"     : .simulator,
            "iPod1,1"    : .iPod1,
            "iPod2,1"    : .iPod2,
            "iPod3,1"    : .iPod3,
            "iPod4,1"    : .iPod4,
            "iPod5,1"    : .iPod5,
            "iPad2,1"    : .iPad2,
            "iPad2,2"    : .iPad2,
            "iPad2,3"    : .iPad2,
            "iPad2,4"    : .iPad2,
            "iPad2,5"    : .iPadMini1,
            "iPad2,6"    : .iPadMini1,
            "iPad2,7"    : .iPadMini1,
            "iPhone3,1"  : .iPhone4,
            "iPhone3,2"  : .iPhone4,
            "iPhone3,3"  : .iPhone4,
            "iPhone4,1"  : .iPhone4S,
            "iPhone5,1"  : .iPhone5,
            "iPhone5,2"  : .iPhone5,
            "iPhone5,3"  : .iPhone5C,
            "iPhone5,4"  : .iPhone5C,
            "iPad3,1"    : .iPad3,
            "iPad3,2"    : .iPad3,
            "iPad3,3"    : .iPad3,
            "iPad3,4"    : .iPad4,
            "iPad3,5"    : .iPad4,
            "iPad3,6"    : .iPad4,
            "iPhone6,1"  : .iPhone5S,
            "iPhone6,2"  : .iPhone5S,
            "iPad4,1"    : .iPadAir1,
            "iPad4,2"    : .iPadAir2,
            "iPad4,4"    : .iPadMini2,
            "iPad4,5"    : .iPadMini2,
            "iPad4,6"    : .iPadMini2,
            "iPad4,7"    : .iPadMini3,
            "iPad4,8"    : .iPadMini3,
            "iPad4,9"    : .iPadMini3,
            "iPad6,3"    : .iPadPro9_7,
            "iPad6,11"   : .iPadPro9_7,
            "iPad6,4"    : .iPadPro9_7_cell,
            "iPad6,12"   : .iPadPro9_7_cell,
            "iPad6,7"    : .iPadPro12_9,
            "iPad6,8"    : .iPadPro12_9_cell,
            "iPad7,3"    : .iPadPro10_5,
            "iPad7,4"    : .iPadPro10_5_cell,
            "iPhone7,1"  : .iPhone6plus,
            "iPhone7,2"  : .iPhone6,
            "iPhone8,1"  : .iPhone6S,
            "iPhone8,2"  : .iPhone6Splus,
            "iPhone8,4"  : .iPhoneSE,
            "iPhone9,1"  : .iPhone7,
            "iPhone9,2"  : .iPhone7plus,
            "iPhone9,3"  : .iPhone7,
            "iPhone9,4"  : .iPhone7plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,4" : .iPhone8,
            "iPhone10,5" : .iPhone8plus,
            "iPhone10,6" : .iPhoneX
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return DeviceModel.unrecognized
    }
}
