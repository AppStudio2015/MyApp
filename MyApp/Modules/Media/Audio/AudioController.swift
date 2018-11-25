//
//  AudioController.swift
//  iosNewNavi
//
//  Created by PandoraXY on 2018/11/25.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

let audioFileExtensionSILK = "silk"
let audioFileExtensionM4A = "m4a"
let audioFileExtensionPCM = "pcm"

//MARK: - AudioController

/// 聊天管理器（客户端）
///
/// - 语音播报器
/// - 创建语音播报队列
/// - 语音播放控制
///
class AudioController: NSObject {
    //MARK: -- Typealias
    
    /// 开始操作Block
    public typealias OperationStartBlock = () -> (Void)
    
    /// 操作执行中
    public typealias OperationExecutingBlock = (_ data1: Any?, _ data2: Any?) -> (Void)
    
    /// 结束操作Block
    public typealias OperationFinishBlock = (_ url: URL?, _ duration: Double?, _ flag: Bool?) -> (Void)
    
    /// 操作错误Block
    public typealias OperationErrorBlock = (_ url: URL?, _ error: Error?) -> (Void)
    
    //MARK: -- Properties
    
    private let globalQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1;
        return queue;
    }()
    
    /// 语音播放器
    private var audioPlayer: AVAudioPlayer?
    
    /// 语音录制器
    private var audioRecorder: AVAudioRecorder?
    
    /// Silk编码解码器
//    private var audioSilkCodec: SilkCodec?
    
    /// 语音会话
    private var audioSession: AVAudioSession?
    
    /// 开始播放语音
    private var didStartPlayback: OperationStartBlock?
    
    /// 结束播放语音
    private var didFinishPlayback: OperationFinishBlock?
    
    /// 播放语音错误
    private var playbackError: OperationErrorBlock?
    
    /// 开始录制语音
    private var didStartRecord: OperationStartBlock?
    
    /// 正在录制语音
    private var executingRecord: OperationExecutingBlock?
    
    /// 结束录制语音
    private var didFinishRecord: OperationFinishBlock?
    
    /// 录制语音错误
    private var recordError: OperationErrorBlock?
    
    /// 语音文件URL
    private var audioFileUrl: URL?
    
    /// 是否正在录音
    var isRecording: Bool = false
    
    /// 是否正在编码
    var isEncoding: Bool = false
    
    //MARK: -- Initialization
    
    override init() {
//        self.audioSilkCodec = SilkCodec.init()
        super.init()
    }
    
    deinit {
        audioRecorder?.delegate = nil
        audioPlayer?.delegate = nil
    }
    //MARK: - Private methods
    
    /// 录音设置(AAC)
    ///
    /// - Returns: 设置集合
    fileprivate func recordSettingsForAAC() -> [String : Any] {
        let recordSettings = [AVSampleRateKey:NSNumber(value: 24000.0),
                              AVFormatIDKey:NSNumber(value: kAudioFormatMPEG4AAC),
                              AVNumberOfChannelsKey:NSNumber(value: 1),
                              AVLinearPCMBitDepthKey:NSNumber(value: 16),
                              AVEncoderAudioQualityKey:NSNumber(value: AVAudioQuality.medium.rawValue)]
        return recordSettings
    }
    
    /// 录音设置(PCM)
    ///
    /// - Returns: 设置集合
    fileprivate func recordSettingsForPCM() -> [String : Any] {
        var recordSettins:[String:Any] = [:]
        recordSettins[AVSampleRateKey]             = NSNumber(value: 24000.0)
        recordSettins[AVFormatIDKey]               = NSNumber(value: kAudioFormatLinearPCM)
        recordSettins[AVNumberOfChannelsKey]       = NSNumber(value: 1)
        recordSettins[AVLinearPCMBitDepthKey]      = NSNumber(value: 16)
        recordSettins[AVLinearPCMIsBigEndianKey]   = NSNumber(value: false)
        recordSettins[AVLinearPCMIsFloatKey]       = NSNumber(value: false)
        recordSettins[AVLinearPCMIsNonInterleaved] = NSNumber(value: true)
        recordSettins[AVEncoderAudioQualityKey]    = NSNumber(value: AVAudioQuality.medium.rawValue)
        return recordSettins
    }
    
    /// 语音文件生成器
    ///
    /// - Returns: 语音文件名
    fileprivate func recordFileNameGenerator() -> String {
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYYMMddhhmmss"
        let dateString: NSString = dateFormater.string(from: date) as NSString
//        dateString = dateString.appendingPathExtension(audioFileExtensionM4A)! as NSString
        let name = dateString.appendingPathExtension(audioFileExtensionPCM)! as NSString
//        let defaultDirectory = DefaultChatVoiceFolder as NSString
//        let file = defaultDirectory.appendingPathComponent(dateString as String)
        NSLog("RecordFileName:\(name)")
        let fileName = checkDefaultDataFileExist(withName: name as String)
        
        return fileName.filePath
    }
    
    /// Recorder初始化
    fileprivate func initAudioRecorder() -> AVAudioRecorder? {
//        let audioSessionManager = MBAudioSessionManager.sharedManager
//        if audioSessionManager.setAudioSession(true, type: .record) == false {
//            return nil
//        }
//        let audioSession = AVAudioSession.sharedInstance()
        do {
//            if #available(iOS 10.0, *) {
//                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeVoiceChat, options: [])
//            } else {
//                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            }
            
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
//            try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            
            let fileName = self.recordFileNameGenerator()
            let fileUrl = URL(string: fileName)
            let recordSettings = self.recordSettingsForPCM()
            let audioRecorder = try AVAudioRecorder.init(url: fileUrl!, settings: recordSettings)
            return audioRecorder
        } catch let error as NSError {
            NSLog("InitRecorderError:\(error.domain)")
        }
        
        return nil
    }
    
    /// 更新录音计量
    fileprivate func updateRecordMeters() -> Void {
        OperationQueue().addOperation { [weak self] in
            repeat{
                if let strongSelf = self, strongSelf.isRecording == true {
                    strongSelf.audioRecorder?.updateMeters()
                    let averagePower: Float? = strongSelf.audioRecorder?.averagePower(forChannel: 0)
                    let peakPower: Float? = strongSelf.audioRecorder?.peakPower(forChannel: 0)
                    if let block = strongSelf.executingRecord {
                        block(averagePower, peakPower)
                    }
                    Thread.sleep(forTimeInterval: 0.5)
                } else {
                    break
                }
            } while (true)
        }
    }
    
    //MARK: - Public methods
    
    //MARK: -- Player
    
    /// 播放语音
    ///
    /// - Parameters:
    ///   - name: 语音文件名(包括后缀名)
    ///   - didStartPlayback: 开始播放回调
    ///   - didFinishPlayback: 结束播放回调
    ///   - playbackError: 播放失败回调
    public func playRecordWithName(_ name: String, didStartPlayback: @escaping OperationStartBlock, didFinishPlayback: @escaping OperationFinishBlock, playbackError: @escaping OperationErrorBlock) {
        let ret = checkDefaultDataFileExist(withName: name)
        if !ret.exist {
            let error = NSError.init(domain: "Audio does not exist", code: 300, userInfo: nil)
            playbackError(nil, error)
            return
        }
        
        let filePath = ret.filePath
        let fileURL = URL(string: filePath)
        if let url = fileURL {
            self.playRecordWithURL(url, didStartPlayback: didStartPlayback, didFinishPlayback: didFinishPlayback, playbackError: playbackError)
        }
    }
    
    /// 播放语音
    ///
    /// - Parameters:
    ///   - id: 语音ID
    ///   - didStartPlayback: 开始播放回调
    ///   - didFinishPlayback: 结束播放回调
    ///   - playbackError: 播放失败回调
    public func playRecordWithId(_ id: String, didStartPlayback: @escaping OperationStartBlock, didFinishPlayback: @escaping OperationFinishBlock, playbackError: @escaping OperationErrorBlock) {
        let fileName = id + ".silk"
        self.playRecordWithName(fileName, didStartPlayback: didStartPlayback, didFinishPlayback: didFinishPlayback, playbackError: playbackError)
    }
    
    /// 播放语音
    ///
    /// - Parameters:
    ///   - url: 语音URL
    ///   - didStartPlayback: 开始播放回调
    ///   - didFinishPlayback: 结束播放回调
    ///   - playbackError: 播放失败回调
    public func playRecordWithURL(_ url: URL, didStartPlayback: @escaping OperationStartBlock, didFinishPlayback: @escaping OperationFinishBlock, playbackError: @escaping OperationErrorBlock) {
        
        self.didStartPlayback = didStartPlayback
        self.didFinishPlayback = didFinishPlayback
        self.playbackError = playbackError
        
        if let recorder = self.audioRecorder, recorder.isRecording {
            self.stopRecord()
        }
        
        if let player = self.audioPlayer {
            if player.isPlaying {
                player.stop()
            }
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 10.0, *) {
                try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            } else {
                // Fallback on earlier versions
                if audioSession.responds(to: NSSelectorFromString("setCategory:withOptions:error:")) {
                    audioSession.perform(NSSelectorFromString("setCategory:withOptions:error:"), with: AVAudioSession.Category.playback, with:[])
                }
            }
            let audioPlayer = try AVAudioPlayer.init(contentsOf: url)
            self.audioPlayer = audioPlayer
            self.audioPlayer?.delegate = self
            self.audioPlayer?.play()
            self.didStartPlayback!()
        } catch let error as NSError {
            NSLog("PlaybackFailed:\(error.localizedDescription)")
            self.playbackError!(url, error)
        }
        
    }
    
    /// 暂停播放语音
    public func pausePlayRecord() -> Void {
        if let player = self.audioPlayer {
            if player.isPlaying {
                player.pause()
            }
        }
    }
    
    /// 恢复播放语音
    public func resumePlayRecord() -> Void {
        if let player = self.audioPlayer {
            if player.isPlaying {
                player.pause()
            }
        }
    }
    
    /// 停止播放语音
    public func stopPlayRecord(){
        if let player = self.audioPlayer {
            if player.isPlaying {
                player.stop()
            }
        }
        
        //JRIA:IPHONENAVP-5898
        //FIXME:暂时无法获取是否有其它音频在播放，暂时注释掉下面的方法，否则会影响导航语音播报
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setActive(false)
//        } catch let error as NSError {
//            print("StopRecordFailed:\(error.domain)")
//        }
    }
    
    //MARK: -- Recorder
    
    /// 开始录音
    ///
    /// - Parameters:
    ///   - didStartRecord: 开始录音回调
    ///   - didFinishRecord: 结束录音回调
    ///   - recordError: 录音失败回调
    public func startRecord(didStartRecord: @escaping OperationStartBlock, executingRecord: @escaping OperationExecutingBlock, didFinishRecord: @escaping OperationFinishBlock,recordError: @escaping OperationErrorBlock) {
        
        self.didStartRecord  = didStartRecord
        self.executingRecord = executingRecord
        self.didFinishRecord = didFinishRecord
        self.recordError     = recordError
        
        if let recorder = self.audioRecorder {
            if recorder.isRecording {
                self.stopRecord()
            }
        }
        
        // 以下代码会阻塞线程，放入任务队列中执行
        let task =  BlockOperation {
            if let recorder = self.initAudioRecorder() {
                self.audioRecorder = recorder
                self.audioRecorder?.delegate = self
                self.audioRecorder?.isMeteringEnabled = true
                self.audioRecorder?.prepareToRecord()
            } else {
                if let block = self.recordError {
                    let error = NSError.init(domain: "InitRecorderError", code: 700, userInfo: nil)
                    block(nil, error)
                }
                return
            }
            
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
                //FIXME:如何获取AudioSession是否为Active状态？
//                try audioSession.setActive(true)
                self.audioRecorder?.record()
                self.isRecording = true
                if let block = self.didStartRecord {
                    block()
                }
                self.updateRecordMeters()
//            } catch let error as NSError {
//                print("StartReocrdFailed:\(error.domain)")
//                if let block = self.recordError {
//                    block(nil, error)
//                }
//            }
        }
        task.queuePriority = .high
        globalQueue.addOperation(task)
    }
    
    /// 停止录音
    public func stopRecord() {
        // 因编码是同步的 录音文件较大时编码时间比较长 所以如果是在编码中时 不能停止录音
        if let recorder = self.audioRecorder, recorder.isRecording, self.isEncoding {
            return
        }
        
        if let recorder = self.audioRecorder {
            recorder.stop()
            self.isRecording = false
        }
        
        // 以下代码会阻塞线程，放入任务队列中执行
        let task =  BlockOperation {
//            let audioSessionManager = MBAudioSessionManager.sharedManager
//            if audioSessionManager.setAudioSession(false, type: .record) == false {
//                return
//            }
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
                //JRIA:IPHONENAVP-5898
                //FIXME:暂时无法获取是否有其它音频在播放，暂时注释掉下面的方法，否则会影响导航语音播报
//                try audioSession.setActive(false)
//            } catch let error as NSError {
//                print("StopRecordFailed:\(error.domain)")
//            }
        }
//        task.queuePriority = .high
        globalQueue.addOperation(task)
    }
}

//MARK: - AVAudioPlayerDelegate

extension AudioController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let url = player.url
        let duration = player.duration
        if let block = self.didFinishPlayback {
            block(url, duration, flag)
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        let url = player.url
        if let block = self.playbackError {
            block(url, error)
        }
    }
}

//MARK: - AVAudioRecorderDelegate

extension AudioController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
//        globalQueue.addOperation {
//            [weak self] () -> Void in
//            guard let strongSelf = self else { return }
            if flag {
//                let fileUrl = recorder.url
            } else {

            }
//        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        if let block = self.recordError {
            block(recorder.url, error)
        }
    }
}
