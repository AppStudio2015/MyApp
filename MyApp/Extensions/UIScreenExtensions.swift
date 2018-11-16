//
//  UIDeviceExtension.swift
//  MyApp
//
//  Created by PandoraXY on 25/02/2018.
//  Copyright © 2018 AppStudio Inc. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /// 当前机型相对设计机型(iPhone6）的宽度系数
    static private var widthScaleFactor: CGFloat = {
        return min(UIScreen.main.bounds.size.width ,UIScreen.main.bounds.size.height)/375.0
    }()
    
    /// 当前机型相对设计机型(iPhone6）的高度系数
    static private var heightScaleFactor: CGFloat = {
        return max(UIScreen.main.bounds.size.width ,UIScreen.main.bounds.size.height)/667.0
    }()
    
    /// 获取屏幕高度
    @objc class func height() -> CGFloat {
        return UIScreen.main.bounds.size.height;
    }
    
    /// 获取屏幕宽度
    @objc class func width() -> CGFloat {
        return UIScreen.main.bounds.size.width;
    }
    
    /// 获取屏幕size
    @objc class func size() -> CGSize {
        return UIScreen.main.bounds.size;
    }
    
    /// 获取屏幕size短边
    @objc class func minSide() -> CGFloat {
        return fmin(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width);
    }
    
    /// 获取屏幕size长边
    @objc class func maxSide() -> CGFloat {
        return fmax(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width);
    }
    
    /// 获取状态栏高度（竖屏）
    @objc class func statusBarHeight() -> CGFloat {
        return UIDevice.current.isX() ? 44.0 : 20.0
    }
    
    /// 规整尺寸 以0.5为单位进行向下取整处理
    ///
    /// - Parameter size: 原尺寸
    /// - Returns: 规整后的尺寸
    @objc static func normalizerSize(_ size: CGFloat) -> CGFloat {
        return floor(size * 2.0) * 0.5
    }
    
    /// 将设计尺寸转换为在当前机型上的真实宽度
    ///
    /// - Parameter designWidth: 设计宽度（iPhone6）
    /// - Returns: 真实尺寸（0.5对齐）
    @objc static func relativeWidth(_ designWidth: CGFloat) -> CGFloat {
        return self.normalizerSize(widthScaleFactor * designWidth)
    }
    
    /// 将设计尺寸转换为在当前机型上的真实宽度
    ///
    /// - Parameter designHeight: 设计高度（iPhone6）
    /// - Returns: 真实尺寸（0.5对齐）
    @objc static func relativeHeight(_ designHeight: CGFloat) -> CGFloat {
        return self.normalizerSize(heightScaleFactor * designHeight)
    }
    
}
