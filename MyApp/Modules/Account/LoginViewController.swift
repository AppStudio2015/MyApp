//
//  LoginViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/5.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginView = LoginView.init(frame: self.view.bounds)
        loginView.delegate = self
        self.view = loginView
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    deinit {
        
    }

    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    // MARK: - Public Functions

}

extension LoginViewController: LoginViewDelegate {
    
    func forgetPassword() {
        let forgetPasswordViewController = RegisterViewController()
        forgetPasswordViewController.title = "ForgetPassword"
        forgetPasswordViewController.registerType = .change
        self.navigationController?.pushViewController(forgetPasswordViewController, animated: true)
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    func register() {
        let registerViewController = RegisterViewController()
        registerViewController.title = "Register"
        registerViewController.registerType = .register
        self.navigationController?.pushViewController(registerViewController, animated: true)
//        self.navigationController?.navigationBar.isHidden = false
    }
}
