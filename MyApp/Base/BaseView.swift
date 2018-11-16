//
//  BaseView.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
   
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    // MARK: - Public Functions
}
