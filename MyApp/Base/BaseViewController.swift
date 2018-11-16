//
//  BaseViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Public Properties
    #if DEBUG
    private(set) var stackView: UIStackView = UIStackView.init()
    #endif
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        #if DEBUG
        self.addTestButtons()
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    #if DEBUG
    private func addTestButton() -> Void {
        let button = UIButton.init(frame: CGRect(x: 40, y: 200, width: self.view.frame.width - 80, height: 40))
        button.setTitle(self.testModuleName(), for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(self.testModule), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    private func addTestButtons() -> Void {
        let count: Int = self.testModuleNames().count
        let spaceing: CGFloat = 2.0
        let margin: CGFloat = 40.0
        let defaultH: CGFloat = 40.0
        let stackViewW: CGFloat = self.view.frame.width - margin * 2
        let stackViewH: CGFloat = CGFloat(count) * defaultH + CGFloat(count - 1) * spaceing
        let stackViewX: CGFloat = margin
        let stackViewY: CGFloat = self.view.frame.height - stackViewH - (UIDevice.isX ? 85 : 50)
        self.stackView = UIStackView.init(frame: CGRect.init(x: stackViewX, y: stackViewY, width: stackViewW, height: stackViewH))
        self.stackView.spacing = spaceing
        self.stackView.alignment = .fill
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        
        for i in 0..<count {
            
            let button = UIButton.init(type: .custom)
            button.setTitle(self.testModuleNames()[i], for: .normal)
            button.backgroundColor = UIColor.blue
            button.tag = i
            button.addTarget(self, action: #selector(self.testModules(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            
        }
        
        self.view.addSubview(stackView)
    }
    #endif
    
    // MARK: - Public Functions
    
    #if DEBUG
    @objc public func testModule() -> Void {
        
    }
    
    @objc public func testModules(sender: UIButton) -> Void {
        
    }
    
    @objc public func testModuleName() -> String {
        return "TestModule"
    }
    
    @objc public func testModuleNames() -> [String] {
        return ["TestModule"]
    }
    #endif
}
