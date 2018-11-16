//
//  GuideView.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

/// 引导视图
class GuideView: BaseView {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    /// 引导页数
    fileprivate let numberOfPages = 4
    fileprivate lazy var guideImages: [UIImageView] = {
        var array: [UIImageView] = [UIImageView]()
        for index in 0..<self.numberOfPages {
            let imageName = "guide/GuideImage_\(index + 1)"
            let image = UIImage.init(named: imageName)
//            let imageView = UIImageView.init(image: image)
            let imageView = UIImageView.init()
            imageView.backgroundColor = UIColor.randomColor
            imageView.frame = .zero
            array.append(imageView)
        }
        
        return array
    }()
    
    /// 页面控制器
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = .zero
        pageControl.numberOfPages = self.numberOfPages
        pageControl.backgroundColor = UIColor.clear
        pageControl.pageIndicatorTintColor = UIColor.myColorFrom(hexString: "BED2FF")
        pageControl.currentPageIndicatorTintColor = UIColor.myColorFrom(hexString: "3C78FF")
        pageControl.isHidden = false
        self.addSubview(pageControl)
        
        return pageControl
    }()
    
    /// 开始体验按钮
    fileprivate lazy var startButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("开始体验", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.myColorFrom(hexString: "7FAFF9")
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = UIDevice.isPad ? 2.0 : 1.0
        button.layer.cornerRadius = UIDevice.isPad ? 16.0 : (UIDevice.current.isX() ? 12 : 10)
        button.isHidden = true
        button.addTarget(self,
                         action: #selector(self.startButtonOnClick),
                         for: .touchUpInside)
        self.addSubview(button)
        
        return button
    }()
    
    /// 滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        return scrollView
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for imageView in self.guideImages {
            self.scrollView.addSubview(imageView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let currentFrame = self.frame
        
        let pageControlH: CGFloat = 40.0
        let pageControlW: CGFloat = UIDevice.isPad ? 260 : 150
        let pageControlY: CGFloat = currentFrame.size.height - (UIDevice.isPad ? 80 : (UIDevice.current.isX() ? 60 : 40))
        let pageControlX: CGFloat = (currentFrame.size.width - pageControlW) / 2
        
        let marginBottom: CGFloat = UIDevice.isPad ? 110 : currentFrame.size.height * 0.114
        let startButtonH: CGFloat = UIDevice.isPad ? 50.0 : 36.0
        let startButtonW: CGFloat = UIDevice.isPad ? 220.0 : 142
        let startButtonX: CGFloat = (currentFrame.size.width - startButtonW)/2
        let startButtonY: CGFloat = currentFrame.size.height - startButtonH - (UIDevice.isPad ? marginBottom : (UIDevice.current.isX() ? marginBottom - 10 : marginBottom))
        
        
        let startBtnFont: UIFont = UIDevice.isPad ? UIFont.mediumFont30() : UIFont.mediumFont28()
        
        self.scrollView.frame = currentFrame
        self.pageControl.frame = CGRect(x:pageControlX, y:pageControlY, width: pageControlW, height: pageControlH)
        self.startButton.frame = CGRect(x:startButtonX, y: startButtonY, width: startButtonW, height: startButtonH)
        self.startButton.titleLabel?.font = startBtnFont
        self.startButton.layer.cornerRadius = startButtonH / 2
        
        for index in 0..<self.guideImages.count {
            let imageView = self.guideImages[index]
            imageView.frame = CGRect(x: currentFrame.size.width * CGFloat(index),
                                     y: 0,
                                     width: currentFrame.size.width,
                                     height: currentFrame.size.height)
        }
        
        self.scrollView.contentSize = CGSize(width: currentFrame.size.width * CGFloat(self.numberOfPages),
                                             height: currentFrame.size.height)
    }
    
    deinit {
        self.guideImages.removeAll()
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Public Functions
    
    // MARK: - Target Actions
    
    /// 开始体验按钮处理
    @objc func startButtonOnClick() {
        self.removeFromSuperview()
    }
    
    // MARK: - Private Functions
}

// MARK: - Extensions

// MARK: - UIScrollViewDelegate
extension GuideView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        self.pageControl.currentPage = Int(offset.x / self.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if self.pageControl.currentPage == self.numberOfPages - 1 {
            UIView.animate(withDuration: 0.5) {
                self.startButton.isHidden = false
                self.pageControl.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.startButton.isHidden = true
                self.pageControl.isHidden = false
            }
        }
    }
}
