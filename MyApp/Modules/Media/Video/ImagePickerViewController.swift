//
//  ImagePickerViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/9.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

public enum MediaType: Int {
    case audio
    case video
    case photo
}

class ImagePickerViewController: BaseViewController {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var isFrontCamera: Bool = true
    private lazy var videoImagePickerCtl: UIImagePickerController = {
        let imagePickerController = UIImagePickerController.init()
        
        return imagePickerController
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        
    }
    
    // MARK: - Override Methods
    #if DEBUG
    override func testModules(sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            if self.isAuthorizationAvailable(for: .video) {
                if self.isVideoRecordingAvailable() {
                    self.defaultVideoSettings()
                    self.startImagePickerController()
                }
            }
            break
        case 1:
            self.dismiss(animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    override func testModuleNames() -> [String] {
        return ["VideoCapture","Back"]
    }
    
    #endif

    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    /// 是否可以打开摄像头
    ///
    /// - Returns: True 可以; False 不可
    private func isVideoRecordingAvailable() -> Bool {
        let status = UIImagePickerController.isSourceTypeAvailable(.camera)
        return status
    }
    
    /// 是否可以打开相册
    ///
    /// - Returns: True 可以; False 不可
    private func isPhotoLibararyAvailabel() -> Bool {
        let status = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        return status
    }
    
    /// 是否可以保存到相册
    ///
    /// - Returns: True 可以; False 不可
    private func isPhotoLibrarySavingAvailable() -> Bool {
        let status = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        return status
    }
    
    /// 获取相机、录音、相册权限
    ///
    /// - Parameter mediaType: 媒体类型
    /// - Returns: True 有权限; False 无权限
    private func isAuthorizationAvailable(for mediaType: MediaType) -> Bool {
        switch mediaType {
        case .audio:
            let authorStatus = AVCaptureDevice.authorizationStatus(for: .audio)
            if authorStatus == .denied || authorStatus == .restricted {
                return false
            }
            break
        case .video:
            let authorStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if authorStatus == .denied || authorStatus == .restricted {
                return false
            }
            break
        case .photo:
            let authorStatus = PHPhotoLibrary.authorizationStatus()
            if authorStatus == .denied || authorStatus == .restricted {
                return false
            }
            break
        }
        return true
    }
    
    /// 启动视频拍摄
    private func startImagePickerController() -> Void {
        self.present(self.videoImagePickerCtl, animated: true) {
            
        }
    }
    
    // MARK: - Public Functions
    
    /// 默认视频录制设置
    public func defaultVideoSettings() -> Void {
        self.videoImagePickerCtl.sourceType = .camera
        self.videoImagePickerCtl.mediaTypes = [(kUTTypeMovie as String)] // UIImagePickerController.availableMediaTypes(for: .camera)
        self.videoImagePickerCtl.delegate = self
        
        self.videoImagePickerCtl.showsCameraControls = true
        self.videoImagePickerCtl.videoQuality = .typeMedium
        self.videoImagePickerCtl.cameraFlashMode = .auto
        self.videoImagePickerCtl.videoMaximumDuration = 10.0
        self.switchCamera()
    }
    
    /// 切换摄像头
    public func switchCamera() -> Void {
        if self.isFrontCamera {
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                self.videoImagePickerCtl.cameraDevice = .rear
                self.isFrontCamera = false
            }
        } else {
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                self.videoImagePickerCtl.cameraDevice = .front
                self.isFrontCamera = true
            }
        }
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
    }
}

extension ImagePickerViewController: UINavigationControllerDelegate {
     
}
