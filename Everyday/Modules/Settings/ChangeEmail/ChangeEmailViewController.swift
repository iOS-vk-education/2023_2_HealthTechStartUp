//
//  ChangeEmailViewController.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit
import PinLayout

final class ChangeEmailViewController: UIViewController {
    // MARK: - Private properties
    
    private let output: ChangeEmailViewOutput
    
    private let passwordField = UITextField()
    private let newEmailField = UITextField()
    private let confirmButton = UIButton()
    private let forgotPasswordButton = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let navBarTitle = UILabel()
    
    init(output: ChangeEmailViewOutput) {
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

// MARK: - Setup

private extension ChangeEmailViewController {
    
    private func setup() {
        setupScrollView()
        setupContentView()
        setupFields()
        setupButtons()
    }
    
    private func setupScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupContentView() {
        contentView.addSubviews(newEmailField, passwordField, confirmButton, forgotPasswordButton)
    }
    
    private func setupFields() {
        [newEmailField, passwordField].forEach { field in
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
    
    private func setupButtons() {
        confirmButton.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
        confirmButton.layer.cornerRadius = Constants.cornerRadius
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
    }
    
    // MARK: - Layout
    
    private func layout() {
        scrollView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
        
        contentView.pin
            .top(to: scrollView.edge.top)
            .horizontally()
            .bottom(to: scrollView.edge.bottom)
        
        newEmailField.pin
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
            .top(to: newEmailField.edge.bottom)
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
    func didTapWholeView() {
        view.endEditing(true)
    }
    
    @objc
    func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            output.getBack()
        }
    }
    
    @objc
    func didTapConfirmButton() {
        let newEmail = self.newEmailField.text ?? ""
        let password = self.passwordField.text ?? ""
        
        output.didTapConfirmButton(with: newEmail, and: password)
    }
    
    @objc
    func didTapForgotPasswordButton() {
        output.didTapOnForgotPasswordButton()
    }
}

// MARK: - ChangeEmailViewInput

extension ChangeEmailViewController: ChangeEmailViewInput {
    func showAlert(with type: AlertType) {
        AlertService.shared.presentAlert(on: self, alertType: type)
    }
    
    func configure(with model: ChangeEmailViewModel) {
        navBarTitle.attributedText = model.changeEmailTitle
        newEmailField.attributedPlaceholder = model.newEmailFieldTitle
        passwordField.attributedPlaceholder = model.passwordFieldTitle
        confirmButton.setAttributedTitle(model.confirmButtonTitle, for: .normal)
        forgotPasswordButton.setAttributedTitle(model.forgotPasswordTitle, for: .normal)
    }
}

// MARK: - Constants

private extension ChangeEmailViewController {
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
