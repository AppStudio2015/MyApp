//
//  CommonWebView.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/5.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit
import WebKit

class CommonWebView: UIView {

    // MARK: - Public Properties
    public lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration.init()
        let webView = WKWebView.init(frame: CGRect.zero, configuration: config)
        
        self.addSubview(webView)
        
        return webView
    }()
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    deinit {
        //
    }
}
