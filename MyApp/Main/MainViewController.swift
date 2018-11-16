//
//  MainViewController.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/3.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private lazy var homeNaviController: UINavigationController = {
        let viewController = HomeViewController()
        viewController.title = "Home"
//        viewController.view.backgroundColor = UIColor.red
        self.setTabBarItem(&viewController.tabBarItem, title: "Home", selectedImageName: "", normalImageName: "")
        let naviController = UINavigationController.init(rootViewController: viewController)
        naviController.navigationBar.barTintColor = UIColor.blue
        naviController.navigationBar.topItem?.title = "Home"
        naviController.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        
        return naviController
    }()
    
    private lazy var courseNaviController: UINavigationController = {
        let viewController = CourseViewController()
        viewController.title = "Course"
//        viewController.view.backgroundColor = UIColor.yellow
        self.setTabBarItem(&viewController.tabBarItem, title: "Course", selectedImageName: "", normalImageName: "")
        let naviController = UINavigationController.init(rootViewController: viewController)
        naviController.navigationBar.topItem?.title = "Courses"
        
        return naviController
    }()
    
    private lazy var onlineMallNaviController: UINavigationController = {
        let viewController = OnlineMallViewController()
        viewController.title = "Mall"
//        viewController.view.backgroundColor = UIColor.green
        self.setTabBarItem(&viewController.tabBarItem, title: "Mall", selectedImageName: "", normalImageName: "")
        let naviController = UINavigationController.init(rootViewController: viewController)
        naviController.navigationBar.topItem?.title = "OnlineMall"
        
        return naviController
    }()
    
    private lazy var userNaviController: UINavigationController = {
        let viewController = UserViewController()
        viewController.title = "User"
//        viewController.view.backgroundColor = UIColor.gray
        self.setTabBarItem(&viewController.tabBarItem, title: "User", selectedImageName: "", normalImageName: "")
        let naviController = UINavigationController.init(rootViewController: viewController)
        naviController.navigationBar.topItem?.title = "User"
        
        return naviController
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.blue
        
        self.setTabBarTheme()
        self.setTabBarItemThemeWith(color: UIColor.black, selectedColor: UIColor.blue)

        self.createViewControllers()
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    private func createViewControllers() -> Void {
        
        self.viewControllers = [self.homeNaviController,
                                self.courseNaviController,
                                self.onlineMallNaviController,
                                self.userNaviController]
    }
    
    private func setTabBarItem(_ tabBarItem: inout UITabBarItem, title: String, selectedImageName: String,  normalImageName: String) -> Void {
        let selectedTabBarImage: UIImage? = UIImage.init(named: selectedImageName)
        selectedTabBarImage?.withRenderingMode(.alwaysOriginal)
        let normalTabBarImage: UIImage? = UIImage.init(named: normalImageName)
        normalTabBarImage?.withRenderingMode(.alwaysOriginal)

        tabBarItem = UITabBarItem.init(title: title, image: normalTabBarImage, selectedImage: selectedTabBarImage)
    }
    
    // MARK: - Public Functions

}

extension UITabBarController {
    
    func setTabBarItemThemeWith(color normalColor: UIColor, selectedColor: UIColor) -> Void {
        
        let normalAttributes: [NSAttributedString.Key : Any] = [.foregroundColor:normalColor,
                                                                .font:UIFont.regularFont28()]
        let selectedAttributes: [NSAttributedString.Key : Any] = [.foregroundColor:selectedColor,
                                                                  .font:UIFont.regularFont28()]
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
    func setTabBarTheme() -> Void {
        
        //去掉UITabBarController上面的黑色线条
//        self.tabBar.barStyle = UIBarStyle.black

        //设置UITabBarController的颜色
        self.tabBar.isTranslucent = false
//        self.tabBar.tintColor = UIColor.white
//        UITabBar.appearance().tintColor = UIColor.black

        //设置阴影
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize.init(width: 0, height: -1)
        self.tabBar.layer.shadowOpacity = 0.3
    }
}
