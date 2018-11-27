//
//  BaseError.swift
//  MyApp
//
//  Created by Qufei on 2018/11/27.
//  Copyright © 2018 Carbar. All rights reserved.
//

import UIKit

//public protocol CustomError: Error {
//    static var domain: String {get}
//    var code: Int {get}
//    var userInfo: [String:Any] {get}
//}

public enum ErrorCode: Int {
    case networkErrorCode = 700
    case parseErrorCode
    case dataErrorCode
}

//public struct RequestError: CustomError {
//
//    enum ErrorKind {
//        case networkError
//        case parseError
//        case dataError
//    }
//
//    public var code: Int {
//        switch ErrorKind.self {
//        case .networkError:
//            return ErrorCode.networkErrorCode.rawValue
//        case .parseError:
//            return ErrorCode.parseErrorCode.rawValue
//        case .dataError:
//            return ErrorCode.dataErrorCode.rawValue
//        }
//    }

//    public static var domain: String {
//        switch self {
//        case .networkError:
//            return ""
//        case .parseError:
//            return ""
//        case .dataError:
//            return ""
//        }
//    }
    
//    public var userInfo: [String : Any]? {
//        switch self {
//        case .networkError:
//            return [:]
//        case .parseError:
//            return [:]
//        case .dataError:
//            return [:]
//        }
//    }
//}
