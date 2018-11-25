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
    case none
    case audio
    case video
    case photo
}

class ImagePickerViewController: BaseViewController {

    // MARK: - Public Properties
    public var mediaType: MediaType = .none
    
    // MARK: - Private Properties
    private var isFrontCamera: Bool = true
    
    /// 视频
    private lazy var videoImagePickerCtrl: UIImagePickerController = {
        let imagePickerController = UIImagePickerController.init()
//        imagePickerController.isEditing = true
        
        return imagePickerController
    }()
    
    /// 图库
    private lazy var photoImagePickerCtrl: UIImagePickerController = {
        let imagePickerController = UIImagePickerController.init()
        imagePickerController.allowsEditing = true
        
        return imagePickerController
    }()
    
    private lazy var takePhotoImagePickerCtrl: UIImagePickerController = {
        let imagePickerController = UIImagePickerController.init()
        imagePickerController.isEditing = true
        
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
                    self.startVideoImagePickerController()
                }
            }
            break
        case 1:
            if self.isAuthorizationAvailable(for: .photo) {
                if self.isPhotoLibararyAvailabel() {
                    self.defaultPhotoSetting()
                    self.startPhotoImagePickerController()
                }
            }
            break;
        case 2:
            if self.isAuthorizationAvailable(for: .photo) {
                if self.isPhotoLibrarySavingAvailable() {
                    self.defultTakePhotoSetting()
                    self.startTakePhotoImagePickerController()
                }
            }
            break
        case 3:
            self.dismiss(animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    override func testModuleNames() -> [String] {
        return ["VideoCapture","PhotoLibrary","TakePhoto","Back"]
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
        case .none:
            return false
        }
        return true
    }
    
    /// 启动视频拍摄
    private func startVideoImagePickerController() -> Void {
        self.present(self.videoImagePickerCtrl, animated: true) {
            //
        }
    }
    
    /// 启动相册
    private func startPhotoImagePickerController() -> Void {
        self.present(self.photoImagePickerCtrl, animated: true) {
            //
        }
    }
    
    private func startTakePhotoImagePickerController() -> Void {
        self.present(self.takePhotoImagePickerCtrl, animated: true) {
            //
        }
    }
    
    // MARK: - Public Functions
    
    /// 默认视频录制设置
    public func defaultVideoSettings() -> Void {
        self.videoImagePickerCtrl.sourceType = .camera
        self.videoImagePickerCtrl.mediaTypes = [(kUTTypeMovie as String)] // UIImagePickerController.availableMediaTypes(for: .camera)
        self.videoImagePickerCtrl.delegate = self
        
        self.videoImagePickerCtrl.showsCameraControls = true
        self.videoImagePickerCtrl.videoQuality = .typeMedium
        self.videoImagePickerCtrl.cameraFlashMode = .auto
        self.videoImagePickerCtrl.videoMaximumDuration = 10.0
        self.switchCamera()
    }
    
    public func defultTakePhotoSetting() -> Void {
        self.takePhotoImagePickerCtrl.sourceType = .camera
        self.takePhotoImagePickerCtrl.mediaTypes = [(kUTTypeImage as String)]
        self.takePhotoImagePickerCtrl.delegate = self
        
        self.takePhotoImagePickerCtrl.showsCameraControls = true
        self.takePhotoImagePickerCtrl.cameraFlashMode = .auto
        self.takePhotoImagePickerCtrl.videoQuality = .typeHigh
    }
    
    public func defaultPhotoSetting() -> Void {
        self.photoImagePickerCtrl.sourceType = .photoLibrary
        self.photoImagePickerCtrl.mediaTypes = [(kUTTypeImage as String)]
        self.photoImagePickerCtrl.delegate = self
        
//        self.photoImagePickerCtrl.
    }
    
    /// 切换摄像头
    public func switchCamera() -> Void {
        if self.isFrontCamera {
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                self.videoImagePickerCtrl.cameraDevice = .rear
                self.isFrontCamera = false
            }
        } else {
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                self.videoImagePickerCtrl.cameraDevice = .front
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
