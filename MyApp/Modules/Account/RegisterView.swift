//
//  RegisterView.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/5.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

public enum RegisterViewType: Int {
    case register
    case change
}

class RegisterView: BaseView {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var viewType: RegisterViewType = .register
    
    /// 手机输入框
    private lazy var phoneTextField: MyTextField = {
        let textField = MyTextField.init(frame: .zero, type: .phoneNumber)
        textField.leftImageName = ""
//        textField.rightButtonTitle = "Code"
        textField.backgroundColor = UIColor.myGrayWhite()
        textField.placeholderString = "Your cell-phone number"
        
        return textField
    }()
    
    /// 验证c码输入框
    private lazy var verificationCodeTextField: MyTextField = {
        let textField = MyTextField.init(frame: .zero, type: .verificationCode)
        textField.leftImageName = ""
        textField.rightButtonTitle = "Code"
        textField.backgroundColor = UIColor.myGrayWhite()
        textField.placeholderString = "Your verification code"
        
        return textField
    }()
    
    /// 密码输入框
    private lazy var pwdTextField: MyTextField = {
        let textField = MyTextField.init(frame: .zero, type: .passwordNormal)
        textField.leftImageName = ""
//        textField.rightButtonTitle = ""
        textField.backgroundColor = UIColor.myGrayWhite()
        textField.placeholderString = "Your password"
        
        return textField
    }()
    
    /// 确认密码输入框
    private lazy var confirmPwdTextField: MyTextField = {
        let textField = MyTextField.init(frame: .zero, type: .passwordNormal)
        textField.leftImageName = ""
//        textField.rightButtonTitle = ""
        textField.backgroundColor = UIColor.myGrayWhite()
        textField.placeholderString = "Your password"
        
        return textField
    }()
    
    /// 注册/修改按钮
    private lazy var regiserButton: UIButton = {
        let button = UIButton.init(type: .custom)
        if self.viewType == .register {
            button.setTitle("Register", for: .normal)
        } else {
            button.setTitle("Change", for: .normal)
        }
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.regularFont36()
        button.backgroundColor = UIColor.myBlue()
        
        self.addSubview(button)
        
        return button
    }()
    
    /// 确认按钮（用户须知、用户隐私）
    private lazy var confirmButton: UIButton = {
        let button = UIButton.init(type: .custom)
//        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
//        button.titleLabel?.textAlignment = .center
//        button.titleLabel?.font = UIFont.regularFont36()
        button.backgroundColor = UIColor.myBlue()
        
        self.addSubview(button)
        
        return button
    }()
    
    /// 输入框Statck
    private lazy var statckView: UIStackView = {
        let aStackView = UIStackView.init(frame: .zero)
        aStackView.addArrangedSubview(self.phoneTextField)
        aStackView.addArrangedSubview(self.verificationCodeTextField)
        aStackView.addArrangedSubview(self.pwdTextField)
        aStackView.addArrangedSubview(self.confirmPwdTextField)
        aStackView.alignment = .fill
        aStackView.distribution = .fillEqually
        aStackView.axis = .vertical
        aStackView.spacing = 10.0
        
        self.addSubview(aStackView)
        
        return aStackView
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, type: RegisterViewType) {
        
        self.init(frame: frame)
        
        self.viewType = type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = UIScreen.relativeWidth(30.0)
        
        let statckViewW: CGFloat = self.frame.width - margin * 2
        let statckViewH: CGFloat = UIScreen.relativeHeight(210.0)
        let statckViewX: CGFloat = margin
        let statckViewY: CGFloat = 88.0
        self.statckView.frame = CGRect(x: statckViewX, y: statckViewY, width: statckViewW, height: statckViewH)
        
        let registerButtonW: CGFloat = statckViewW
        let registerButtonH: CGFloat = UIScreen.relativeHeight(50.0)
        let registerButtonX: CGFloat = (self.frame.width - registerButtonW) / 2
        let registerButtonY: CGFloat = self.statckView.frame.maxY + UIScreen.relativeHeight(22.0)
        self.regiserButton.frame = CGRect(x: registerButtonX, y: registerButtonY, width: registerButtonW, height: registerButtonH)
        
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    // MARK: - Public Functions
}

extension UILabel {
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
    }
}

