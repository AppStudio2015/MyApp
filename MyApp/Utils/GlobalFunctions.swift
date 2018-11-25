//
//  GlobalFunctions.swift
//  iosNewNavi
//
//  Created by PandoraXY on 4/7/15.
//  Copyright (c) 2018 AppStudio Inc. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


/// 默认语音储存路径
public let DefaultAudioFolder: String = "My/Audio"

/// 默认图片储存路径
public let DefaultImageFolder: String = "My/Image"

/// 默认聊天视频储存路径
public let DefaultVideoFolder: String = "My/Video"

/// 剪切板变化保存键值
private let PastboardChangeCountKey: String = "PastboardChangeCountKey"

/**
 *  当前界面是否是竖屏
 *
 *  - returns: 当前界面是否竖屏
 */
public func IsPortrait() -> Bool {
//    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    return UIApplication.shared.statusBarOrientation.isPortrait
}

//MARK: -- FileOperation

/// 创建默认的资源目录，保存语音、图片、视频等
/// 默认资源路径:Documents/My/Audio(Image or Video)
///
/// - Parameter name: 目录名称
public func createDefaultDataFolder(_ name: String) {
    let ret = checkDataFileExist(withName: name)
    if !ret.exist {
        try? FileManager.default.createDirectory(atPath: ret.filePath, withIntermediateDirectories: true, attributes: nil)
    }
}

/// 检查文件或文件夹是否在沙盒的默认语音目录中已经存在
/// 默认路径: My/Audio
///
/// - Parameter name: 文件名或文件夹名(20170808.pcm)
/// - Returns: exist-是否存在,filePath-路径名
public func checkDefaultDataFileExist(withName name: String) -> (exist: Bool, filePath:String) {
    let fileName = (DefaultAudioFolder as NSString).appendingPathComponent(name)
    
    let fileManager = FileManager.default
    let documentsFolderUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    var pathUrl: URL = (documentsFolderUrl[0] as URL)
    pathUrl = pathUrl.appendingPathComponent(fileName)
    let filePath = pathUrl.path
    NSLog("FilePath:\(filePath)")
    
    let exist = fileManager.fileExists(atPath: filePath)
    return (exist, filePath)
}

/// 检查文件或文件夹是否在沙盒的Documents目录中已经存在
/// 语音路径: My/Audio
///
/// - Parameter name: 文件名或文件夹名(My/Audio/20170808.pcm)
/// - Returns: exist-是否存在,filePath-路径名
public func checkDataFileExist(withName name: String) -> (exist: Bool, filePath:String) {
    let fileManager = FileManager.default
    let documentsPath: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsPathStr = documentsPath[0] as NSString
    let filePath = documentsPathStr.appendingPathComponent(name)
    let exist = fileManager.fileExists(atPath: filePath)
    NSLog("FilePath:\(filePath)")
    return (exist, filePath)
}

/// 检查文件或文件夹是否在默认目录中已经存在
///
/// - Parameter url: 文件URL
/// - Returns: exist-是否存在,fileUrl-文件URL
public func checkDataFileExist(withUrl url: URL) -> (exist: Bool, fileUrl:URL) {
    let fileManager = FileManager.default
    let exist = fileManager.fileExists(atPath: url.absoluteString)
    NSLog("FilePath:\(url)")
    return (exist, url)
}

/// 检查文件或文件夹是否已经存在
///
/// - Parameter url: 文件URL
/// - Returns: true,存在; false,不存在
public func checkDataFileExistWithUrl(_ url: URL) -> Bool {
    let fileManager = FileManager.default
    let exist = fileManager.fileExists(atPath: url.absoluteString)
    return exist
}

/// 将下载数据移动到聊天默认相当路径下
///
/// - Parameters:
///   - url: 下载数据URL
///   - toDirectory: 目标路径
///   - byName: 命名
///   - extensionName: 扩展名
/// - Returns: 新路径名
public func moveTmpData(withUrl url: URL, toDirectory: String, byName: String, extensionName: String?) -> String? {
    var fileName = (toDirectory as NSString).appendingPathComponent(byName)
    if let extName = extensionName {
        fileName = (fileName as NSString).appendingPathExtension(extName)!
    }
    
    let file = checkDataFileExist(withName: fileName)
    if !file.exist {
        do {
            //                let data = try NSData.init(contentsOfFile: url.absoluteString, options: NSData.ReadingOptions.dataReadingMapped)
            let fileUrl = NSURL.fileURL(withPath: file.filePath)
            //                data.write(toFile: file.filePath, atomically: true)
            let fileManager = FileManager.default
            try fileManager.moveItem(at: url, to: fileUrl)
        } catch let error as NSError {
            NSLog("MoveFileError:\(error.description)")
        }
        
    } else {
        return file.filePath
    }
    
    let newFile = checkDataFileExist(withName: fileName)
    if newFile.exist {
        return newFile.filePath
    } else {
        return nil
    }
}

/// 将下载数据移动到聊天默认相当路径下
///
/// - Parameters:
///   - data: 下载数据
///   - toDirectory: 目标路径
///   - byName: 命名
///   - extensionName: 扩展名
/// - Returns: 新路径名
public func moveTmpData(_ data: Data, toDirectory: String, byName: String, extensionName: String?) -> String? {
    var fileName = (toDirectory as NSString).appendingPathComponent(byName)
    if let extName = extensionName {
        fileName = (fileName as NSString).appendingPathExtension(extName)!
    }
    
    let file = checkDataFileExist(withName: fileName)
    if !file.exist {
        let ret = (data as NSData).write(toFile: file.filePath, atomically: true)
        if !ret {
            return nil
        }
    } else {
        return file.filePath
    }
    
    let newFile = checkDataFileExist(withName: fileName)
    if newFile.exist {
        return newFile.filePath
    } else {
        return nil
    }
}

/// 重新命名文件
///
/// - Parameters:
///   - fileUrl: 源文件URL
///   - name: 新文件名字
/// - Returns: 新文件URL
public func renameFile(_ fileUrl: URL, withName name: String) -> URL? {
    let filePathUrl = fileUrl.deletingLastPathComponent()
    let fileExtensionName = fileUrl.pathExtension
    
    var newFilePathUrl = filePathUrl.appendingPathComponent(name)
    newFilePathUrl = newFilePathUrl.appendingPathExtension(fileExtensionName)
    NSLog("NewFileUrl:\(newFilePathUrl)")
    NSLog("NewFileAbUrl:\(newFilePathUrl.absoluteURL)")
    var newFile = checkDataFileExist(withUrl: newFilePathUrl)
    if !newFile.exist {
        do {
            let fileManager = FileManager.default
            //                try fileManager.moveItem(at: fileUrl.absoluteURL, to: newFilePathUrl.absoluteURL)
            try fileManager.moveItem(atPath: fileUrl.absoluteString, toPath: newFilePathUrl.absoluteString)
        } catch let error as NSError {
            NSLog("RenameFileError:\(error.description)")
        }
        
    } else {
        NSLog("RenameFileSuccess:\(newFilePathUrl)")
        return newFilePathUrl
    }
    
    newFile = checkDataFileExist(withUrl: newFilePathUrl)
    if newFile.exist {
        NSLog("RenameFileSuccess:\(newFilePathUrl)")
        return newFile.fileUrl
    } else {
        return nil
    }
    
}

/// 根据文件名称删除沙盒中Documents的文件
/// 默认资源路径:My/Audio
///
/// - Parameter name: 文件名称
public func deleteDefaultDataFileWithName(_ name: String) -> Void {
    let fileName = (DefaultAudioFolder as NSString).appendingPathComponent(name)
    
    let ret = checkDataFileExist(withName: fileName)
    if ret.exist {
        try! FileManager.default.removeItem(atPath: ret.filePath)
    }
}

/// 删除沙盒中Documents下语音路径中的所有文件
/// 默认资源路径:My/Audio
///
/// - Parameter name: 路径名称
public func deleteAllDefaultDataFileWithFolderName(_ name: String) -> Void {
    let ret = checkDataFileExist(withName: name)
    if ret.exist {
        let fileArray = FileManager.default.subpaths(atPath: ret.filePath)
        if let files = fileArray {
            for file in files {
                try! FileManager.default.removeItem(atPath: ret.filePath + "/\(file)")
            }
        }
    }
}

/// 获取文件大小
///
/// - Parameter url: 文件URL
/// - Returns: 文件大小
public func fileSize(withFileUrl url: URL) -> Double {
    let filePath = url.absoluteString
    return fileSize(withFilePath: filePath)
}

/// 获取文件大小
///
/// - Parameter path: 文件路径名
/// - Returns: 文件大小
public func fileSize(withFilePath path: String) -> Double {
    var size: Double = 0
    let fileManager = FileManager.default
    let exist = fileManager.fileExists(atPath: path)
    if exist {
        do {
            let attributes = try fileManager.attributesOfItem(atPath: path)
            let fileSize = attributes[FileAttributeKey.size] as! Int
            size = Double(fileSize)
        } catch let error as NSError {
            NSLog("FileSizeFailed:\(error.domain)")
        }
    }
    
    return size
}

//MARK: -- Audio

/// 获取音频时长(AVURLAsset)
///
/// - Parameter url: 音频URL
/// - Returns: 时长(秒)
public func audioDurationWtihUrl(_ url: URL) -> Double {
    var duration: CMTime
    let avUrlAsset = AVURLAsset.init(url: url, options: nil)
    duration = avUrlAsset.duration
    return CMTimeGetSeconds(duration)
}

/// 获取音频时长(AVURLAsset)
///
/// - Parameter url: 音频URL
/// - Returns: 时长(秒)
public func audioDuration(withUrl url: URL) -> Double {
    var audioFileId: AudioFileID? = nil
    let cfUrl = url as CFURL
    let ret: OSStatus = AudioFileOpenURL(cfUrl, AudioFilePermissions.readPermission, 0, &audioFileId)
    if ret != noErr {
        return Double(0)
    }
    
    var outDataSize: UInt32 = 0
    var thePropSize: UInt64 = 0
    
    AudioFileGetProperty(audioFileId!, kAudioFilePropertyEstimatedDuration, &outDataSize, &thePropSize)
    AudioFileClose(audioFileId!)
    
    let duration = thePropSize
    return Double(duration)
}

/// 获取音频时长(AVAudioPlayer)
///
/// - Parameter url: 音频URL
/// - Returns: 时长(秒)
public func audioDurationWithFileUrl(_ url: URL) -> Double {
    do {
        let audiPlayer = try AVAudioPlayer.init(contentsOf: url)
        let duration = audiPlayer.duration
        audiPlayer.stop()
        return Double(duration)
    } catch {
        return Double(0)
    }
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

