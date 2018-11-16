//
//  UIFontExtensions.swift
//  MyApp
//
//  Created by PandoraXY on 2017/11/10.
//  Copyright © 2017年 AppStudio Inc. All rights reserved.
//

import UIKit

// MARK: - UIFont Extension
/// - 字体的大小是UED根据iPhone6的尺寸定义的，输出值是像素单位为PX，而开发中使用的则是PT
/// - UED采用的字体是 苹果的【苹方（PingFangSC）】字体
/// - PT与PX的换算方法：pt=(px/96)*72 DPI为96时；但是实际效果还是大，所以按控件尺寸计算：pt=px/2
/// - iPhone字体适配原则：根据UIScreen的宽度与iPhone6的宽度的比值来进行适配
/// - iPad字体适配原则：视情况而定，暂时放大1.2倍，因为1.5倍有点大
extension UIFont {
    /// PX字体转PT字体
    ///
    /// - Parameters:
    ///   - size: PX字体大小
    ///   - hasWeight: 是否有字重
    /// - Returns: PT字体
    @objc class func ptFont(ofSize size: CGFloat, hasWeight: Bool) -> UIFont {
        let scale = fmin(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 375
//        let newFont = UIFont.init(name: "PingFangSC-Regular", size: fontSize)
        let fontSize = size * scale
        
        if #available(iOS 8.2, *) {
            if hasWeight {
                return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
            } else {
                return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
            }
        } else {
            if hasWeight {
                return UIFont.boldSystemFont(ofSize: fontSize)
            } else {
                return UIFont.systemFont(ofSize: fontSize)
            }
        }
    }
    
    @objc class func regularFont160() -> UIFont {
        return UIFont.ptFont(ofSize: 80.0, hasWeight: false)
    }
    
    @objc class func mediumFont160() -> UIFont {
        return UIFont.ptFont(ofSize: 80.0, hasWeight: true)
    }
    
    @objc class func regularFont108() -> UIFont {
        return UIFont.ptFont(ofSize: 54.0, hasWeight: false)
    }
    
    @objc class func mediumFont108() -> UIFont {
        return UIFont.ptFont(ofSize: 54.0, hasWeight: true)
    }
    
    @objc class func mediumFont100() -> UIFont {
        return UIFont.ptFont(ofSize: 50.0, hasWeight: true)
    }
    
    @objc class func mediumFont88() -> UIFont {
        return UIFont.ptFont(ofSize: 44.0, hasWeight: true)
    }
    
    @objc class func regularFont80() -> UIFont {
        return UIFont.ptFont(ofSize: 40.0, hasWeight: false)
    }
    
    @objc class func mediumFont80() -> UIFont {
        return UIFont.ptFont(ofSize: 40.0, hasWeight: true)
    }
    
    @objc class func mediumFont64() -> UIFont {
        return UIFont.ptFont(ofSize: 32.0, hasWeight: true)
    }
    
    @objc class func regularFont60() -> UIFont {
        return UIFont.ptFont(ofSize: 30.0, hasWeight: false)
    }
    
    @objc class func mediumFont56() -> UIFont {
        return UIFont.ptFont(ofSize: 28.0, hasWeight: true)
    }
    
    @objc class func mediumFont50() -> UIFont {
        return UIFont.ptFont(ofSize: 25.0, hasWeight: true)
    }
    
    @objc class func mediumFont48() -> UIFont {
        return UIFont.ptFont(ofSize: 24.0, hasWeight: true)
    }
    
    @objc class func mediumFont44() -> UIFont {
        return UIFont.ptFont(ofSize: 22.0, hasWeight: true)
    }
    
    @objc class func regularFont40() -> UIFont {
        return UIFont.ptFont(ofSize: 20.0, hasWeight: false)
    }
    
    @objc class func mediumFont40() -> UIFont {
        return UIFont.ptFont(ofSize: 20.0, hasWeight: true)
    }
    
    @objc class func regularFont36() -> UIFont {
        return UIFont.ptFont(ofSize: 18.0, hasWeight: false)
    }
    
    @objc class func mediumFont36() -> UIFont {
        return UIFont.ptFont(ofSize: 18.0, hasWeight: true)
    }
    
    @objc class func regularFont34() -> UIFont {
        return UIFont.ptFont(ofSize: 17.0, hasWeight: false)
    }
    
    @objc class func mediumFont34() -> UIFont {
        return UIFont.ptFont(ofSize: 17.0, hasWeight: true)
    }
    
    @objc class func regularFont32() -> UIFont {
        return UIFont.ptFont(ofSize: 16.0, hasWeight: false)
    }
    
    @objc class func mediumFont32() -> UIFont {
        return UIFont.ptFont(ofSize: 16.0, hasWeight: true)
    }
    
    @objc class func regularFont30() -> UIFont {
        return UIFont.ptFont(ofSize: 15.0, hasWeight: false)
    }
    
    @objc class func mediumFont30() -> UIFont {
        return UIFont.ptFont(ofSize: 15.0, hasWeight: true)
    }
    
    @objc class func regularFont28() -> UIFont {
        return UIFont.ptFont(ofSize: 14.0, hasWeight: false)
    }
    
    @objc class func mediumFont28() -> UIFont {
         return UIFont.ptFont(ofSize: 14.0, hasWeight: true)
    }
    
    @objc class func regularFont26() -> UIFont {
        return UIFont.ptFont(ofSize: 13.0, hasWeight: false)
    }
    
    @objc class func mediumFont26() -> UIFont {
        return UIFont.ptFont(ofSize: 13.0, hasWeight: true)
    }
    
    @objc class func regularFont24() -> UIFont {
        return UIFont.ptFont(ofSize: 12.0, hasWeight: false)
    }
    
    @objc class func regularFont22() -> UIFont {
        return UIFont.ptFont(ofSize: 11.0, hasWeight: false)
    }
}
