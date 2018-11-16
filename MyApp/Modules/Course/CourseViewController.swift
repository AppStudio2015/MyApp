//
//  CourseViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/3.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class CourseViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private lazy var simpleVideoRecorder: SimpleVideoRecorder = {
        let videoRecorder = SimpleVideoRecorder.init()
        
        return videoRecorder
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Override Functions
    
    #if DEBUG
    override func testModules(sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            let imagePickerVC = ImagePickerViewController()
            self.present(imagePickerVC, animated: true, completion: nil)
            break;
        case 1:
            self.testAVCaptureStart()
            break;
        case 2:
            self.testAVCaptureStop()
            break;
        default:
            break
        }
        
    }
    
    override func testModuleNames() -> [String] {
        return ["ImagePicker", "StartAVCapture", "StopAVCapture"]
    }
    
    #endif
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    private func testAVCaptureStart() -> Void {
        let viewX: CGFloat = 16.0
        let viewY: CGFloat = self.navigationController?.navigationBar.frame.maxY ?? 88.0
        let viewW: CGFloat = self.view.frame.width - viewX * 2
        let viewH: CGFloat = self.view.frame.height - viewY - self.stackView.frame.height
        let view = UIView.init(frame: CGRect(x: viewX, y: viewY, width: viewW, height: viewH))
        self.view.addSubview(view)
        
        self.simpleVideoRecorder.superView = view
        self.simpleVideoRecorder.previewRect = view.frame
        self.simpleVideoRecorder.defaultSettings()
        self.simpleVideoRecorder.start()
    }
    
    private func testAVCaptureStop() -> Void {
        self.simpleVideoRecorder.stop()
    }
    
    // MARK: - Public Functions
}
