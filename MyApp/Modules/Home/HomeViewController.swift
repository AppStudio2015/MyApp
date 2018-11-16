//
//  HomeViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/3.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        self.view = HomeView.init(frame: self.view.frame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func testAlamofire() -> Void {
        let Alamofire = SessionManager.default
        Alamofire.request("https://httpbin.org/get").response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }

}
