//
//  SignUpViewController.swift
//  Everyday
//
//  Created by Михаил on 28.04.2024.
//  
//

import UIKit
import PinLayout

final class SignUpViewController: UIViewController {
    // MARK: - Private properties
    
    private let output: SignUpViewOutput
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let togglePasswordButton = UIButton(type: .custom)
    private let loginButton = UIButton()
    private let signupButton = UIButton()
    private var activeTextField: UITextField?
    
    // MARK: - Lifecycle

    init(output: SignUpViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        output.didLoadView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(didTapCloseButton)
            )

        navigationItem.leftBarButtonItem?.tintColor = Constants.textColor

        setup()

        view.addSubview(scrollView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Setup

    private func setup() {
        setupScrollView()
        setupContentView()
        setupLabel()
        setupTextFields()
        setupButtons()
    }

    private func setupScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
    }

    private func setupContentView() {
        contentView.addSubviews(titleLabel, emailTextField, passwordTextField,
                                togglePasswordButton, loginButton, signupButton)
    }

    private func setupLabel() {
        titleLabel.textAlignment = .center
    }

    private func setupTextFields() {
        for field in [emailTextField, passwordTextField] {
            field.textColor = Constants.textColor
            field.autocapitalizationType = .none
            field.tintColor = Constants.accentColor
            field.autocorrectionType = .no
            field.leftViewMode = .always
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.TextField.textAlignerWidth, height: field.frame.height))
            field.layer.cornerRadius = Constants.TextField.cornerRadius
            field.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
            field.delegate = self
        }

        emailTextField.keyboardType = .emailAddress

        passwordTextField.isSecureTextEntry = true
        passwordTextField.passwordRules = nil
        setupPasswordTextFieldRightView()
    }

    private func setupPasswordTextFieldRightView() {
        let toggleButtonContainer = UIView(frame: CGRect(x: .zero, y: .zero,
                                                         width: Constants.Buttons.togglePasswordButtonSize + Constants.TextField.textAlignerWidth,
                                                         height: Constants.TextField.height))
        togglePasswordButton.frame = CGRect(x: .zero, y: .zero,
                                            width: Constants.Buttons.togglePasswordButtonSize,
                                            height: Constants.TextField.height)
        toggleButtonContainer.addSubview(togglePasswordButton)

        let paddingView = UIView(frame: CGRect(x: Constants.Buttons.togglePasswordButtonSize, y: .zero,
                                               width: Constants.TextField.textAlignerWidth,
                                               height: Constants.TextField.height))
        toggleButtonContainer.addSubview(paddingView)

        passwordTextField.rightView = toggleButtonContainer
        passwordTextField.rightViewMode = .always
    }

    private func setupButtons() {
        for button in [loginButton, signupButton] {
            button.clipsToBounds = true
            button.layer.cornerRadius = Constants.Buttons.cornerRadius
        }

        signupButton.layer.cornerRadius = Constants.Buttons.cornerRadius
        signupButton.backgroundColor = Constants.accentColor

        togglePasswordButton.contentMode = .scaleAspectFill
        togglePasswordButton.tintColor = Constants.accentColor

        togglePasswordButton.addTarget(self, action: #selector(didTapShowPasswordButton), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    // MARK: - Layout

    private func layout() {
        scrollView.pin
            .all()

        contentView.pin
            .all()

        titleLabel.pin
            .top()
            .hCenter()
            .size(Constants.Label.size)
            .sizeToFit()

        emailTextField.pin
            .below(of: titleLabel, aligned: .center)
            .marginTop(Constants.TextField.marginTop)
            .width(Constants.TextField.width)
            .height(Constants.TextField.height)

        passwordTextField.pin
            .below(of: emailTextField, aligned: .center)
            .marginTop(Constants.TextField.marginTop)
            .width(Constants.TextField.width)
            .height(Constants.TextField.height)

        togglePasswordButton.pin
            .size(Constants.Buttons.togglePasswordButtonSize)
            .right()
            .vCenter()

        loginButton.pin
            .below(of: passwordTextField, aligned: .center)
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.height)

        signupButton.pin
            .bottom(view.pin.safeArea.bottom)
            .hCenter()
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.height)
    }
    
    // MARK: - Actions
    
    @objc 
    private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let activeTextField = activeTextField else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let buttonBottomMargin: CGFloat = activeTextField == passwordTextField ? Constants.TextField.passwordBottom : Constants.TextField.emailBottom

        let newButtonBottom = self.view.frame.height - keyboardHeight - buttonBottomMargin

        self.signupButton.pin
            .bottom(newButtonBottom)
            .hCenter()
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.height)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc 
    private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.signupButton.pin
                .bottom(self.view.frame.height - self.view.safeAreaInsets.bottom)
                .hCenter()
                .width(Constants.Buttons.width)
                .height(Constants.Buttons.height)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func didTapShowPasswordButton() {
        passwordTextField.isSecureTextEntry.toggle()
        let isOpen = !passwordTextField.isSecureTextEntry
        (passwordTextField.rightView as? UIButton)?.isSelected = isOpen
    }

    @objc
    private func didTapLoginButton() {
        output.didTapLoginButton()
    }

    @objc
    private func didTapSignupButton() {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        animateButton(with: signupButton)
        output.didTapSignupButton(with: email, and: password)
    }

    @objc
    private func didTapCloseButton() {
        output.didTapCloseButton()
    }
    
    // MARK: - Helpers

    private func animateButton(with button: UIButton) {
        UIView.animate(withDuration: Constants.Buttons.transformDuration, animations: {
            button.transform = CGAffineTransform(scaleX: Constants.Buttons.transform, y: Constants.Buttons.transform)
        }, completion: { _ in
            UIView.animate(withDuration: Constants.Buttons.transformDuration) {
                button.transform = .identity
            }
        })
    }
}

// MARK: - View Input

extension SignUpViewController: SignUpViewInput {
    func configure(with model: SignUpViewModel) {
        titleLabel.attributedText = model.titleLabelText
        emailTextField.attributedPlaceholder = model.emailTextFieldPlaceholder
        passwordTextField.attributedPlaceholder = model.passwordTextFieldPlaceholder
        loginButton.setAttributedTitle(model.loginButtonTitle, for: .normal)
        signupButton.setAttributedTitle(model.signupButtonTitle, for: .normal)
        togglePasswordButton.setImage(model.showPasswordImage, for: .selected)
        togglePasswordButton.setImage(model.hidePasswordImage, for: .normal)
    }
    
    func showAlert(with type: AlertType) {
        AlertService.shared.presentAlert(on: self, alertType: type)
    }
}

// MARK: - UITextField Delegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}

// MARK: - Constants

extension SignUpViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        static let textColor: UIColor = UIColor.Text.primary
        static let accentColor: UIColor = UIColor.UI.accent
        static let gray: UIColor = .gray

        struct Label {
            static let size: CGSize = CGSize(width: 100, height: 40)
        }

        struct TextField {
            static let marginTop: CGFloat = 10
            static let height: CGFloat = 50
            static let cornerRadius: CGFloat = 10
            static let width = 80%
            static let colorOpacity: CGFloat = 0.1

            static let textAlignerWidth: CGFloat = 10
            static let emailBottom: CGFloat = 64
            static let passwordBottom: CGFloat = 84
        }

        struct Buttons {
            static let togglePasswordButtonSize: CGFloat = 40
            static let cornerRadius: CGFloat = 10
            static let height: CGFloat = 50
            static let width = 80%
            static let transform: CGFloat = 0.9
            static let transformDuration: CGFloat = 0.1
        }
    }
}
