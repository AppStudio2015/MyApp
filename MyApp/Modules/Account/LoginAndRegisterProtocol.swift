//
//  LoginAndRegisterProtocol.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/8.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

/// 登录与注册协议
protocol LoginAndRegisterProtocol: NSObjectProtocol {
    
    
    /// 登录成功代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    ///   - result: 登录结果
    func loginSuccess(from taget: UIViewController, withResult result: Any?)
    
    /// 登录失败代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    ///   - error: 登录错误
    func loginFailure(from taget: UIViewController, withError error: Any?)
    
    /// 登录取消代理
    ///
    /// - Parameters:
    ///   - taget: 登录控制器
    func loginCancellation(from taget: UIViewController)
    
    /// 注册成功代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    ///   - result: 注册结果
    func registerSuccess(from taget: UIViewController, withResult result: Any?)
    
    /// 注册失败代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    ///   - error: 注册错误
    func registerFailure(from taget: UIViewController, withError error: Any?)
    
    /// 注册取消代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    func registerCancellation(from taget: UIViewController)
    
    /// 修改密码成功代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    ///   - result: 修改结果
    func changePasswordSuccess(from taget: UIViewController, withResult result: Any?)
    
    /// 修改密码成功代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    ///   - error: 修改错误
    func changePasswordFailure(from taget: UIViewController, withError error: Any?)
    
    /// 修改密码成功代理
    ///
    /// - Parameters:
    ///   - taget: 控制器
    func changePasswordCancellation(from taget: UIViewController)
}
