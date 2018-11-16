//
//  RegisterViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/5.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Public Properties
    public var registerType: RegisterViewType = .register
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let registerView = RegisterView.init(frame: self.view.bounds, type: self.registerType)
        self.view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        
    }

    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    // MARK: - Public Functions
}
