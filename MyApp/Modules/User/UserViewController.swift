//
//  UserViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/3.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton.init(frame: CGRect(x: 40, y: 200, width: 100, height: 40))
        button.setTitle("TestLogin", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(testlogin), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    

    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    @objc private func testlogin() -> Void {
        let loginVC = LoginViewController()
        let naviController = UINavigationController.init(rootViewController: loginVC)
        self.present(naviController, animated: true, completion: nil)
        naviController.navigationBar.isHidden = true
    }
    
    // MARK: - Public Functions

}
