//
//  LoginView.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/5.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

/// 自定义输入框类型
///
/// - none: 标准输入框
/// - phoneNumber: 手机号
/// - passwordNormal: 设置密码/确认密码
/// - passwordForget: 忘记密码
/// - verificationCode: 验证码
public enum MyTextFieldType: UInt {
    case none
    case phoneNumber
    case passwordNormal
    case passwordForget
    case verificationCode
}

class MyTextField: UITextField {
    
    // MARK: - Public Properties
    
    /// 输入框内左侧图片名称
    public var leftImageName: String?
    
    /// 输入框内右则按钮名称
    public var rightButtonTitle: String?
    
    /// 自定义Placeholder字体
    public var placeholderString: String?{
        set {
            guard newValue != nil else {
                return
            }
            let attributes:[NSAttributedString.Key:Any] = [.foregroundColor:UIColor.myGray(),
                                                           .font:UIFont.regularFont32()]
            self.attributedPlaceholder = NSAttributedString.init(string: newValue!, attributes: attributes)
        }
        get {
            return self.placeholder
        }
    }
    
    /// 输入框类型
    private var type: MyTextFieldType = .phoneNumber
    
    // MARK: - Private Properties
    
    /// 边距
    private let margin: CGFloat = 10.0
    
    /// 输入框内左侧视图
    fileprivate(set) lazy var leftImageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.backgroundColor = UIColor.red
        if let imageName = self.leftImageName {
            imageView.image = UIImage.init(named: imageName)
        } else {
            imageView.isHidden = true
        }
        return imageView
    }()
    
    /// 输入框内右侧视图
    fileprivate(set) lazy var rightButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.clear
        
        if let aTitle = self.rightButtonTitle {
            button.setTitle(aTitle, for: .normal)
            button.titleLabel?.font = UIFont.regularFont24()
        } else {
            button.isHidden = true
        }
        
        if self.type == .passwordForget {
            button.layer.borderWidth = 0.0
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.masksToBounds = false
        } else if self.type == .verificationCode {
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.myBlue().cgColor
            button.layer.masksToBounds = true
        } else {
            button.isHidden = true
        }
        
        return button
    }()
    
    // MARK: - Initialization
    
    convenience init(frame: CGRect, type: MyTextFieldType) {
        self.init(frame: frame)
        
        self.type = type
        if type == .passwordForget || type == .verificationCode  {
            self.leftViewMode = .always
            self.rightViewMode = .always
        } else if type == .phoneNumber || type == .phoneNumber {
            self.leftViewMode = .always
        } else {
            self.leftViewMode = .never
            self.rightViewMode = .never
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.borderStyle = UITextField.BorderStyle.line
//        self.borderStyle = UITextField.BorderStyle.bezel
//        self.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.placeholderRect(forBounds: bounds)
//        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        return rect.inset(by: insets)
//    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        if self.type == .none || (self.leftImageName == nil && self.rightButtonTitle == nil) {
            return rect
        }
        let insets = UIEdgeInsets(top: 0, left: self.margin + 5, bottom: 0, right: self.margin)
        return rect.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        if self.type == .none || (self.leftImageName == nil && self.rightButtonTitle == nil) {
            return rect
        }
        let insets = UIEdgeInsets(top: 0, left: self.margin + 5, bottom: 0, right: self.margin)
        return rect.inset(by: insets)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.type == .none || (self.leftImageName == nil && self.rightButtonTitle == nil) {
            return
        }
        
        if self.leftImageName != nil {
            let leftViewW: CGFloat = 20.0
            let leftViewH: CGFloat = self.frame.height - self.margin * 2
            let leftViewX: CGFloat = self.margin
            let leftViewY: CGFloat = self.margin
            self.leftImageView.frame = CGRect(x: leftViewX, y: leftViewY, width: leftViewW, height: leftViewH)
            self.leftView = self.leftImageView
        }
        
        if (self.type == .passwordForget || self.type == .verificationCode) && self.rightButtonTitle != nil {
            let rightViewW: CGFloat = UIScreen.relativeWidth(80.0)
            let rightViewH: CGFloat = UIScreen.relativeHeight(25.0)
            let rightViewX: CGFloat = self.frame.width - rightViewW - self.margin
            let rightViewY: CGFloat = (self.frame.height - rightViewH) / 2
            self.rightButton.frame = CGRect(x: rightViewX, y: rightViewY, width: rightViewW, height: rightViewH)
            if self.type == .verificationCode {
                self.rightButton.layer.cornerRadius = rightViewH / 2
            }
            self.rightView = self.rightButton
        }
    }
    
    // MARK: - Public Functions
    
    // MARK: - Private Functions
    
}

// MARK: - LoginViewDelegate
public protocol LoginViewDelegate: NSObjectProtocol {
    func forgetPassword()
    func register()
}

// MARK: - LoginView

/// 登录视图
class LoginView: BaseView {
    
    // MARK: - Private Properties
    public weak var delegate: LoginViewDelegate?
    
    /// 商品图标
    private lazy var brandIconView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.image = UIImage.init(named: "")
        imageView.backgroundColor = UIColor.red
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    /// 商品名称
    private lazy var brandLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = UIColor.black
        label.text = "启明跆拳道"
        label.font = UIFont.init(name: "HanziPenSC-W3", size: 28.0)
        label.textAlignment = .center
        
        self.addSubview(label)
        return label
    }()
    
    /// 手机输入框
    private lazy var phoneTextField: MyTextField = {
        let textField = MyTextField.init(frame: .zero, type: .phoneNumber)
        textField.leftImageName = ""
        textField.rightButtonTitle = "Code"
        textField.backgroundColor = UIColor.myGrayWhite()
        textField.placeholderString = "Your cell-phone number"
        
        return textField
    }()
    
    /// 密码输入框
    private lazy var pwdTextField: MyTextField = {
        let textField = MyTextField.init(frame: .zero, type: .passwordForget)
        textField.leftImageName = ""
        textField.rightButtonTitle = "Forget"
        textField.backgroundColor = UIColor.myGrayWhite()
        textField.placeholderString = "Your password"
        textField.rightButton.addTarget(self, action: #selector(self.forgetPwdAction(_:)), for: .touchUpInside)
        
        return textField
    }()
    
    /// 登录按钮
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.regularFont36()
        button.backgroundColor = UIColor.myBlue()
        
        self.addSubview(button)
        
        return button
    }()
    
    /// 注册按钮
    private lazy var regiserButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.myBlue(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.regularFont24()
        button.backgroundColor = UIColor.clear
        
        button.addTarget(self, action: #selector(self.registerAction(_:)), for: .touchUpInside)
        
        self.addSubview(button)
        
        return button
    }()
    
    private lazy var splitLineLayer1: CALayer = {
        let layer = CALayer.init()
        layer.backgroundColor = UIColor.mySilverGray().cgColor
        
        self.layer.addSublayer(layer)
        
        return layer
    }()
    
    private lazy var splitLineLayer2: CALayer = {
        let layer = CALayer.init()
        layer.backgroundColor = UIColor.mySilverGray().cgColor
        
        self.layer.addSublayer(layer)
        
        return layer
    }()
    
    /// 输入框Statck
    private lazy var statckView: UIStackView = {
        let aStackView = UIStackView.init(frame: .zero)
        aStackView.addArrangedSubview(self.phoneTextField)
        aStackView.addArrangedSubview(self.pwdTextField)
        aStackView.alignment = .fill
        aStackView.distribution = .fillEqually
        aStackView.axis = .vertical
        aStackView.spacing = 10.0
        
        self.addSubview(aStackView)
        
        return aStackView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = UIScreen.relativeWidth(30.0)
        
        let bandIconW: CGFloat = UIScreen.relativeWidth(82.0)
        let bandIconH: CGFloat = UIScreen.relativeHeight(90.0)
        let bandIconX: CGFloat = (self.frame.width - bandIconW) / 2
        let bandIconY: CGFloat = UIScreen.relativeHeight(88.0)
        self.brandIconView.frame = CGRect(x: bandIconX, y: bandIconY, width: bandIconW, height: bandIconH)
        
        let bandLabelW: CGFloat = self.frame.width - margin * 2
        let bandLabelH: CGFloat = UIScreen.relativeHeight(50.0)
        let bandLabelX: CGFloat = (self.frame.width - bandLabelW) / 2
        let bandLabelY: CGFloat = self.brandIconView.frame.maxY
        self.brandLabel.frame = CGRect(x: bandLabelX, y: bandLabelY, width: bandLabelW, height: bandLabelH)
        
//        self.phoneTextField.frame = CGRect(x: 20, y: 100, width: 300, height: 60)
        
        let statckViewW: CGFloat = self.frame.width - margin * 2
        let statckViewH: CGFloat = UIScreen.relativeHeight(100.0)
        let statckViewX: CGFloat = margin
        let statckViewY: CGFloat = self.brandLabel.frame.maxY + UIScreen.relativeHeight(34.0)
        self.statckView.frame = CGRect(x: statckViewX, y: statckViewY, width: statckViewW, height: statckViewH)
        
        let loginButtonW: CGFloat = statckViewW
        let loginButtonH: CGFloat = UIScreen.relativeHeight(50.0)
        let loginButtonX: CGFloat = margin
        let loginButtonY: CGFloat = self.statckView.frame.maxY + UIScreen.relativeHeight(30.0)
        self.loginButton.frame = CGRect(x: loginButtonX, y: loginButtonY, width: loginButtonW, height: loginButtonH)
        
        let registerButtonW: CGFloat = UIScreen.relativeWidth(52.0)
        let registerButtonH: CGFloat = UIScreen.relativeHeight(12.0)
        let splitLineW: CGFloat = (self.frame.width - margin * 2 - registerButtonW - UIScreen.relativeWidth(20)) / 2
        let splitLineH: CGFloat = 1.0
        let splitLineX1: CGFloat = margin
        let splitLineX2: CGFloat = self.frame.width - margin - splitLineW
        let splitLineY: CGFloat = self.loginButton.frame.maxY + UIScreen.relativeHeight(28.0)
        self.splitLineLayer1.frame = CGRect(x: splitLineX1, y: splitLineY, width: splitLineW, height: splitLineH)
        self.splitLineLayer2.frame = CGRect(x: splitLineX2, y: splitLineY, width: splitLineW, height: splitLineH)
        
        
        let registerButtonX: CGFloat = (self.frame.width - registerButtonW) / 2
        let registerButtonY: CGFloat = self.loginButton.frame.maxY + UIScreen.relativeHeight(22.0)
        self.regiserButton.frame = CGRect(x: registerButtonX, y: registerButtonY, width: registerButtonW, height: registerButtonH)
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    // MARK: - Public Functions
    
    // MARK: - Target Actions
    
    @objc private func forgetPwdAction(_ sender: UIButton) -> Void {
        self.delegate?.forgetPassword()
    }
    
    @objc private func registerAction(_ sender: UIButton) -> Void {
        self.delegate?.register()
    }

}
