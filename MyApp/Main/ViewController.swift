//
//  ViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit
//import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testAlamofire()
        self.testDevice()
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
    
    private func testDevice() -> Void {
        let deviceModel = UIDevice.deviceModel
        print("CurrentDevice: \(deviceModel.description())")
    }
}

