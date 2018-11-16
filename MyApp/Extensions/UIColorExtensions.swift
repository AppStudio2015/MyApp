//
//  UIColorExtensions.swift
//  MyApp
//
//  Created by PandoraXY on 25/02/2018.
//  Copyright © 2018 AppStudio Inc. All rights reserved.
//

import UIKit

extension UIColor {
    
    open class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    /// 蓝色(#3C78FF)
    ///
    /// - Returns: Blue
    @objc class func myBlue() -> UIColor {
        return UIColor(red: 60.0/255.0, green: 120.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    /// 浅蓝色(#76A0FF)
    ///
    /// - Returns: LightBlue
    @objc class func myLightBlue() -> UIColor {
        return UIColor(red: 118.0/255.0, green: 160.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    /// 红色(#FF4D4D)
    ///
    /// - Returns: Red
    @objc class func myRed() -> UIColor{
        return UIColor(red: 255.0/255.0, green: 77.0/255.0, blue: 77.0/255.0, alpha: 1.0)
    }
    
    /// 黄色(#FFBD00)
    ///
    /// - Returns: Yellow
    @objc class func myYellow() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 189.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    /// 绿色(#00B700)
    ///
    /// - Returns: Green
    @objc class func myGreen() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 183.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    /// 白色(#FFFFFF)
    ///
    /// - Returns: WhiteColor
    //    class func myWhiteColor() -> UIColor {
    //        return UIColor.white
    //    }
    
    /// 浅白(#F8F8F8)
    ///
    /// - Returns: LightWhite
    @objc class func myLightWhite() -> UIColor{
        return UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    }
    
    /// 银白色（#F2F2F2）
    ///
    /// - Returns: SilverWhite
    @objc class func mySilverWhite() -> UIColor {
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    }
    
    /// 灰白色（#E9E9E9）
    ///
    /// - Returns: GrayWhite
    @objc class func myGrayWhite() -> UIColor {
        return UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1.0)
    }
    
    /// 黑色(#000000)
    ///
    /// - Returns: BlackColor
    //    class func myBlackColor() -> UIColor {
    //        return UIColor.black
    //    }
    
    /// 浅黑(#222426)
    ///
    /// - Returns: LightBlack
    @objc class func myLightBlack() -> UIColor {
        return UIColor(red: 34.0/255.0, green: 36.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    }
    
    /// 碳黑(#0E141A)
    ///
    /// - Returns: CarbonBlack
    @objc class func myCarbonBlack() -> UIColor {
        return UIColor(red: 14.0/255.0, green: 20.0/255.0, blue: 26.0/255.0, alpha: 1.0)
    }
    
    /// 碳黑(#0E141A)
    ///
    /// - Parameter alpha: 透明度
    /// - Returns: TransparentCarbonBlack
    @objc class func myCarbonBlack(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: 14.0/255.0, green: 20.0/255.0, blue: 26.0/255.0, alpha: alpha)
    }
    
    /// 深黑(#12181E)
    ///
    /// - Returns: DarkBlack
    @objc class func myDarkBlack() -> UIColor {
        return UIColor(red: 18.0/255.0, green: 24.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    }
    
    /// 青黑(#1A2028)
    ///
    /// - Returns: BlueBlack
    @objc class func myBlueBlack() -> UIColor {
        return UIColor(red: 26.0/255.0, green: 32.0/255.0, blue: 40.0/255.0, alpha: 1.0)
    }
    
    /// 深灰色（#333333）
    @objc class func myDarkGray() -> UIColor {
        return UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    /// 浅灰色(#666666)
    ///
    /// - Returns: LightGray
    @objc class func myLightGray() -> UIColor {
        return UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    /// 灰色(#888888)
    ///
    /// - Returns: Gray
    @objc class func myGray() -> UIColor {
        return UIColor(red: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    }
    
    /// 暗灰色(#AAAAAA)
    ///
    /// - Returns: DimGray
    @objc class func myDimGray() -> UIColor {
        return UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    }
    
    /// 银灰色(#CCCCCC)
    ///
    /// - Returns: SilverGray
    @objc class func mySilverGray() -> UIColor {
        return UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    }
    
    /// 银灰色(#CCCCCC)
    ///
    /// - Parameter alpha: 透明度
    /// - Returns: TransparentSilverGray
    @objc class func mySilverGray(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: alpha)
    }
    
    /// 淡灰色(#D2D2D2)
    ///
    /// - Returns: PaleGray
    @objc class func myPaleGray() -> UIColor {
        return UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    }
    
    /// 深红色(#B91E46)
    ///
    /// - Returns: deepred
    @objc class func myDeepRed() -> UIColor{
        return UIColor(red: 185.0/255.0, green: 30.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    }
    
    /// 十六进制数值转换颜色值
    ///
    /// - Parameter hex: 颜色值（十六进制有效）
    /// - Returns: UIColor类型颜色
    @objc class func myColorFrom(hex: UInt32) -> UIColor{
        let r = (hex >> 16) & 0xFF
        let g = (hex >> 8) & 0xFF
        let b = (hex) & 0xFF
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    /// 字符串转换颜色值
    ///
    /// - Parameter hexString: 字符串
    /// - Returns: UIColor类型颜色
    @objc class func myColorFrom(hexString: String) -> UIColor{
        return myColorFrom(string: hexString, alpha: 1.0)
    }
    
    /// 字符串转换颜色值 自定义透明度
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - alpha: 透明度
    /// - Returns: UIColor类型颜色
    @objc class func myColorFrom(string: String, alpha : CGFloat ) -> UIColor {
        var cString: String = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.count < 6 {
            return UIColor.clear
        }
        if (cString.hasPrefix("0X") || cString.hasPrefix("0x")){
            cString = String(cString[(cString.index(cString.startIndex, offsetBy: 2))...])
        }
        if cString.hasPrefix("#") {
            cString = String(cString[(cString.index(cString.startIndex, offsetBy: 1))...])
        }
        if cString.count != 6 {
            return UIColor.clear
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    /// 颜色值转换字符串
    ///
    /// - Parameter color: UIColor类型颜色
    /// - Returns: 字符串
    @objc class func myStringFrom(color: UIColor) -> String {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        color.getRed(&r, green: &g, blue: &b, alpha: &alpha)
        var rString: String = String(format: "%X", (NSInteger)(r*255))
        var gString: String = String(format: "%X", (NSInteger)(g*255))
        var bString: String = String(format: "%X", (NSInteger)(b*255))

        if (rString.count < 2) {
            rString = "0".appending(rString)
        }
        if (gString.count < 2 ) {
            gString = "0".appending(gString)
        }
        if (bString.count < 2) {
            bString = "0".appending(bString)
        }
        
        return rString + gString + bString
    }
}
