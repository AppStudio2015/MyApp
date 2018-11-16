//
//  GuideViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio Inc. All rights reserved.
//

import UIKit

/// 引导视图控制器
class GuideViewController: BaseViewController {
    
    private lazy var guideView: GuideView = {
        let view = GuideView.init(frame: UIScreen.main.bounds)
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = self.guideView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

