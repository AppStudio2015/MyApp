//
//  GlobalFunctions.swift
//  iosNewNavi
//
//  Created by PandoraXY on 4/7/15.
//  Copyright (c) 2018 AppStudio Inc. All rights reserved.
//

import Foundation
import UIKit

/**
 *  返回当前界面是否是竖屏
 *
 *  - returns: 当前界面是否竖屏
 */
public func IsPortrait() -> Bool {
//    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    return UIApplication.shared.statusBarOrientation.isPortrait
}

/// A factory for NSTimer instances that invoke closures, thereby allowing a weak reference to its context.
class WeakTimerFactory: NSObject {
    
    class WeakTimer: NSObject {
        
        fileprivate var timer: Timer!
        fileprivate let callback: () -> Void
        
        fileprivate init(timeInterval: TimeInterval, userInfo: AnyObject?, repeats: Bool, callback: @escaping () -> Void) {
            
            self.callback = callback
            super.init()
            self.timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(WeakTimer.invokeCallback), userInfo: userInfo, repeats: repeats)
        }
        
        @objc func invokeCallback() {
            
            callback()
        }
    }
    
    /// Returns a new timer that has not yet executed, and is not scheduled for execution.
    @objc static func timerWithTimeInterval(_ timeInterval: TimeInterval, userInfo: AnyObject?, repeats: Bool, callback: @escaping () -> Void) -> Timer {
        
        return WeakTimer(timeInterval: timeInterval, userInfo: userInfo, repeats: repeats, callback: callback).timer
    }
}

