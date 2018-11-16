//
//  SimpleVideoRecorder.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/9.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class SimpleVideoRecorder: NSObject {
    
    // MARK: - Public Properties
    public var previewRect: CGRect = CGRect.zero
    public weak var superView: UIView?
    
    // MARK: - Private Properties
    
    /// 会话
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession.init()
        if session.canSetSessionPreset(AVCaptureSession.Preset.vga640x480) {
            session.sessionPreset = .vga640x480
        }
        
        return session
    }()
    
    /// 视频设备
    private lazy var videoCaptureDevice: AVCaptureDevice? = {
        let device = AVCaptureDevice.default(for: .video)
//        let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInDuoCamera, for: .video, position: .back)
//        device?.isVideoHDREnabled = true
//        device?.activeVideoMinFrameDuration = CMTime.init(value: 1, timescale: 60)
        if let aDevice = device {
            self.configureCameraForHighestFrameRate(for: aDevice)
        }
        
        return device
    }()
    
    /// 视频输入
    private lazy var videoCaptureDeviceInput: AVCaptureDeviceInput? = {
        var deviceInput: AVCaptureDeviceInput? = nil
        if let captureDevice = self.videoCaptureDevice {
            deviceInput = try? AVCaptureDeviceInput.init(device: captureDevice)
        }
        
        return deviceInput
    }()
    
    /// 音频设备
    private lazy var audioCaptureDevice: AVCaptureDevice? = {
        let device = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: AVCaptureDevice.Position.front)
//        let device = AVCaptureDevice.default(for: .audio)
        
        return device
    }()
    
    /// 音频输入
    private lazy var audioCaptureDeviceInput: AVCaptureDeviceInput? = {
        var deviceInput: AVCaptureDeviceInput? = nil
        if let captureDevice = self.audioCaptureDevice {
            deviceInput = try? AVCaptureDeviceInput.init(device: captureDevice)
        }
        
        return deviceInput
    }()
    
    /// 画面输出
    private lazy var captureMovieFileOutput: AVCaptureMovieFileOutput = {
        let movieFileOutput = AVCaptureMovieFileOutput.init()
        
        return movieFileOutput
    }()
    
    /// 视频数据输出
    private lazy var captureVideoDataOutput: AVCaptureVideoDataOutput = {
        let videoDataOutput = AVCaptureVideoDataOutput.init()
        
        return videoDataOutput
        
    }()
    
    /// 视频预览
    private lazy var captureVidePreviewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer.init(session: self.captureSession)
        
        return layer
    }()
    
    // MARK: - Initialization
    override init() {
        super.init()
    }
    
    convenience init(superView: UIView) {
        self.init()
        self.previewRect = superView.frame
        self.superView = superView
        
        self.requestAccess(forMediaType: .video)
        self.requestAccess(forMediaType: .audio)
    }
    
    deinit {
        self.superView = nil
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Public Functions
    
    public func defaultSettings() -> Void {
        if self.isCaptureDeviceAvailable(forMediaType: .video), self.isCaptureDeviceAvailable(forMediaType: .audio) {
            self.configInput()
            self.configMovieFileOutput()
        } else {
            
        }
        
    }
    
    public func start() -> Void {
        if let superView = self.superView {
            superView.layer.insertSublayer(self.captureVidePreviewLayer, at: 0)
        } else {
            return
        }
        self.captureSession.startRunning()
//        self.captureMovieFileOutput.startRecording(to: <#T##URL#>, recordingDelegate: self)
    }
    
    public func stop() -> Void {
        self.captureSession.stopRunning()
//        self.captureMovieFileOutput.stopRecording()
        
        if self.superView != nil {
            self.captureVidePreviewLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: - Private Functions
    
    private func requestAccess(forMediaType type: AVMediaType) -> Void {
        AVCaptureDevice.requestAccess(for: type) { (result) in
            if result {
                print("Allow")
            } else {
                print("Deny")
            }
        }
    }
    
    private func isCaptureDeviceAvailable(forMediaType type: AVMediaType) -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: type)
        if status == .denied || status == .restricted {
            print("Unavailable")
            return false
        }
        print("Available")
        return true
    }
    
    private func configInput() -> Void {
        if let videoInput = self.videoCaptureDeviceInput, self.captureSession.canAddInput(videoInput) {
            self.captureSession.addInput(videoInput)
        }
        
        if let audioInput = self.audioCaptureDeviceInput, self.captureSession.canAddInput(audioInput) {
            self.captureSession.addInput(audioInput)
        }
    }
    
    private func configVideDataOutput() -> Void {
        self.captureVideoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey:kCVPixelFormatType_32BGRA] as [String : Any]
        if self.captureSession.canAddOutput(self.captureVideoDataOutput) {
            self.captureSession.addOutput(self.captureVideoDataOutput)
        }

        if let captureConnection = self.captureVideoDataOutput.connection(with: .video) {
            if captureConnection.isVideoStabilizationSupported {
                captureConnection.preferredVideoStabilizationMode = .auto
            }

            self.captureVidePreviewLayer.frame = CGRect(x: 0, y: 0, width: self.previewRect.width, height: self.previewRect.height)

            if let previewLayerConnection = self.captureVidePreviewLayer.connection {
                captureConnection.videoOrientation = previewLayerConnection.videoOrientation
            }
        }
    }
    
    private func configMovieFileOutput() -> Void {

        if self.captureSession.canAddOutput(self.captureMovieFileOutput) {
            self.captureSession.addOutput(self.captureMovieFileOutput)
        }
        
        if let captureConnection = self.captureMovieFileOutput.connection(with: .video) {
            if captureConnection.isVideoStabilizationSupported {
                captureConnection.preferredVideoStabilizationMode = .auto
            }
            
            self.captureVidePreviewLayer.frame = CGRect(x: 0, y: 0, width: self.previewRect.width, height: self.previewRect.height)
            
            if let previewLayerConnection = self.captureVidePreviewLayer.connection {
                captureConnection.videoOrientation = previewLayerConnection.videoOrientation
            }
        }
    }
    
    private func configureCameraForHighestFrameRate(for device: AVCaptureDevice ) -> Void {
    
        var bestFormat: AVCaptureDevice.Format? = nil
        var bestFrameRateRange: AVFrameRateRange? = nil
        for format in device.formats {
            for range in format.videoSupportedFrameRateRanges {
//                if range.maxFrameRate > bestFrameRateRange.maxFrameRate {
                    bestFormat = format
                    bestFrameRateRange = range
//                }
            }
        }
        if let aBestFormat = bestFormat, let aBestFrameRateRange = bestFrameRateRange {
            
            do {
                try device.lockForConfiguration()
                device.activeFormat = aBestFormat
                device.activeVideoMinFrameDuration = aBestFrameRateRange.minFrameDuration
                device.activeVideoMaxFrameDuration = aBestFrameRateRange.minFrameDuration
                device.unlockForConfiguration()
                
            } catch {
                print("Error:\(error)")
            }
        }
    }

}

extension SimpleVideoRecorder: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
    
}

extension SimpleVideoRecorder: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print(#function)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print(#function)
    }
}
