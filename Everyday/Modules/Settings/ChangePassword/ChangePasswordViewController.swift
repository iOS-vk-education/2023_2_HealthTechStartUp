//
//  ChangePasswordViewController.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit
import PinLayout

final class ChangePasswordViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: ChangePasswordViewOutput
    
    private let passwordField = UITextField()
    private let oldPasswordField = UITextField()
    private let confirmButton = UIButton()
    private let forgotPasswordButton = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let navBarTitle = UILabel()
    init(output: ChangePasswordViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.didLoadView()
        
        view.backgroundColor = Constants.backgroundColor
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapWholeView))
                gestureRecognizer.cancelsTouchesInView = false
                view.addGestureRecognizer(gestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc))
        self.view.addGestureRecognizer(swipeRightGestureRecognizer)
        
        self.navigationItem.titleView = navBarTitle
        navigationController?.navigationBar.tintColor = Constants.accentColor
        
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(scrollView)
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

private extension ChangePasswordViewController {
    
    // MARK: - Setup
    
    func setup() {
        setupScrollView()
        setupContentView()
        setupFields()
        setupButtons()
    }
    
    func setupScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func setupContentView() {
        contentView.addSubviews(oldPasswordField, passwordField, confirmButton, forgotPasswordButton)
    }
    
    func setupFields() {
        [oldPasswordField, passwordField].forEach { field in
            let leftView = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: 10,
                                                height: 0))
            field.autocapitalizationType = .none
            field.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
            field.layer.cornerRadius = Constants.cornerRadius
            field.attributedPlaceholder = NSAttributedString(
                string: field.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
            field.leftView = leftView
            field.leftViewMode = .always
        }
    }
    
    func setupButtons() {
        confirmButton.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
        confirmButton.layer.cornerRadius = Constants.cornerRadius
        
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
    }
    
    // MARK: - Layout
    
    func layout() {
        scrollView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
        
        contentView.pin
            .top(to: scrollView.edge.top)
            .horizontally()
            .bottom(to: scrollView.edge.bottom)
        
        oldPasswordField.pin
            .left()
            .right()
            .top(to: contentView.edge.top)
            .height(Constants.TextField.height)
            .marginTop(Constants.TextField.marginTop)
            .marginRight(Constants.TextField.margin)
            .marginLeft(Constants.TextField.margin)
        
        passwordField.pin
            .left()
            .right()
            .top(to: oldPasswordField.edge.bottom)
            .height(Constants.TextField.height)
            .marginTop(Constants.TextField.marginTop)
            .marginRight(Constants.TextField.margin)
            .marginLeft(Constants.TextField.margin)
        
        confirmButton.pin
            .left()
            .right()
            .top(to: passwordField.edge.bottom)
            .height(Constants.Button.height)
            .marginTop(Constants.Button.marginTop)
            .marginRight(Constants.Button.margin)
            .marginLeft(Constants.Button.margin)
        
        forgotPasswordButton.pin
            .hCenter()
            .height(Constants.Button.height)
            .width(Constants.Button.width)
            .marginBottom(Constants.Button.marginBottom)
            .bottom(to: contentView.edge.bottom)
    }
    
    // MARK: - Actions

    @objc
    private func didTapWholeView() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapConfirmButton() {
        let oldPassword = self.oldPasswordField.text ?? ""
        let newPassword = self.passwordField.text ?? ""
        
        output.didTapConfirmButton(with: oldPassword, and: newPassword)
    }
    
    @objc
    func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            output.getBack()
        }
    }
    
    @objc
    func didTapForgotPasswordButton() {
        output.didTapOnForgotPasswordButton()
    }
}

// MARK: - ChangePasswordViewInput

extension ChangePasswordViewController: ChangePasswordViewInput {
    func showAlert(with key: String, message: String) {
        switch key {
        case "password": AlertManager.showInvalidPasswordAlert(on: self, message: message)
        case "invalidPassword": AlertManager.showInvalidPasswordAlert(on: self)
        default: let error = NSError(domain: "Everydaytech.ru", code: 400)
            AlertManager.showSignInErrorAlert(on: self, with: error)
        }
    }
    
    func configure(with model: ChangePasswordViewModel) {
        navBarTitle.attributedText = model.changePasswordTitle
        oldPasswordField.attributedPlaceholder = model.oldPasswordFieldTitle
        passwordField.attributedPlaceholder = model.newPasswordFieldTitle
        confirmButton.setAttributedTitle(model.confirmButtonTitle, for: .normal)
        forgotPasswordButton.setAttributedTitle(model.forgotPasswordTitle, for: .normal)
    }
}

// MARK: - Constants

private extension ChangePasswordViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        static let buttonColor: UIColor = UIColor.UI.accent
        static let cornerRadius: CGFloat = 12
        
        struct TextField {
            static let margin: CGFloat = 20
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 10
            static let matginBottom: CGFloat = 50
            static let height: CGFloat = 50
        }
        
        struct Button {
            static let margin: CGFloat = 20
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 60
            static let marginBottom: CGFloat = 50
            static let height: CGFloat = 50
            static let width: CGFloat = 200
        }
    }
}
