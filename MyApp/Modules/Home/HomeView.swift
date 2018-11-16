//
//  HomeView.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/3.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

/// 主页视图
class HomeView: UIView {
    // MARK: - Public Properties
    public var imageURLs: [String]? {
        willSet{
            self.cycleView.serverImgArray = newValue
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var cycleView: WRCycleScrollView = {
        let scrollView = WRCycleScrollView.init(frame: .zero)
        scrollView.imgsType = .SERVER
        scrollView.serverImgArray = [
            "http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",
            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",
            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"
        ]
        self.addSubview(scrollView)

        return scrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cycleViewW: CGFloat = self.frame.width
        let cycleViewH: CGFloat = 200.0
        let cycleViewX: CGFloat = 0.0
        let cycleViewY: CGFloat = 88.0
        self.cycleView.frame = CGRect(x: cycleViewX, y: cycleViewY, width: cycleViewW, height: cycleViewH)
        
    }

}
