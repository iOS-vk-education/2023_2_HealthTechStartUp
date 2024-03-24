//
//  SignUpViewController.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//
//

import UIKit

final class SignUpViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: SignUpViewOutput
    private let signWithGoogleButton = UIButton(type: .custom)
    private let signWithVKButton     = UIButton(type: .custom)
    private let signWithAnonymButton = UIButton(type: .custom)
    private let signUpButton         = UIButton(type: .system)
    private let togglePasswordButton = UIButton(type: .custom)
    private let firstSeparator       = UIView()
    private let secondSeparator      = UIView()
    private let emailUnderline       = UIView()
    private let passwordUnderline    = UIView()
    private let separatorLabel       = UILabel()
    private let privacyPolicyLabel   = UILabel()
    private let emailTextField       = UITextField()
    private let passwordTextField    = UITextField()
    private let toolbar              = UIToolbar()
    
    // MARK: - lifecycle
    
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
        setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnPrivacyPolicy))
        privacyPolicyLabel.addGestureRecognizer(tapGesture)
        
        view.addSubviews(signWithGoogleButton, signWithVKButton, signWithAnonymButton,
                         firstSeparator, secondSeparator, separatorLabel,
                         emailTextField, emailUnderline,
                         passwordTextField, passwordUnderline, togglePasswordButton,
                         signUpButton,
                         privacyPolicyLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupButtons()
        setupLines()
        setupLabels()
        setupTextField()
        setupToolBar()
    }
    
    private func setupButtons() {
        for button in [signWithGoogleButton, signWithVKButton, signWithAnonymButton] {
            button.clipsToBounds = true
            button.layer.cornerRadius = Constants.Buttons.cornerRadius
        }
        
        signUpButton.layer.cornerRadius = Constants.Buttons.signUpCornerRadius
        signUpButton.backgroundColor = Constants.accentColor
        
        togglePasswordButton.contentMode = .scaleAspectFill
        togglePasswordButton.tintColor = Constants.accentColor
        
        signWithGoogleButton.addTarget(self, action: #selector(didTapSignWithGoogleButton), for: .touchUpInside)
        signWithVKButton.addTarget(self, action: #selector(didTapSignWithVKButton), for: .touchUpInside)
        signWithAnonymButton.addTarget(self, action: #selector(didTapSignWithAnonymButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        togglePasswordButton.addTarget(self, action: #selector(didTapShowPasswordButton), for: .touchUpInside)
    }
    
    private func setupLines() {
        for separator in [firstSeparator, secondSeparator] {
            separator.layer.borderWidth = Constants.Separators.borderWidth
            separator.layer.borderColor = UIColor.Text.grayElement.cgColor
        }
        
        for line in [emailUnderline, passwordUnderline] {
            line.layer.borderWidth = Constants.Underline.borderWidth
            line.layer.borderColor = UIColor.Text.grayElement.cgColor
        }
    }
    
    private func setupLabels() {
        separatorLabel.sizeToFit()
        
        privacyPolicyLabel.isUserInteractionEnabled = true
        privacyPolicyLabel.numberOfLines = 0
        privacyPolicyLabel.textAlignment = .center
    }
    
    private func setupTextField() {
        for field in [emailTextField, passwordTextField] {
            field.borderStyle = .none
            field.sizeToFit()
            field.textColor = Constants.textColor
            field.autocapitalizationType = .none
            field.tintColor = Constants.accentColor
            field.inputAccessoryView = toolbar
            field.autocorrectionType = .no
        }
        
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = togglePasswordButton
        passwordTextField.rightViewMode = .always
    }
    
    private func setupToolBar() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        
        toolbar.sizeToFit()
        toolbar.items = [flexSpace, doneButton]
        doneButton.tintColor = .white
    }
    
    // MARK: - Layout
    
    private func layout() {
        let spacing = (((view.frame.width - Constants.Buttons.size.width * 3 - Constants.Buttons.marginHorizontal * 2) / 2) * 100).rounded() / 100
        let elementWidth = Constants.Buttons.size.width * 3 + 2 * spacing
        
        signWithGoogleButton.pin
            .top(Constants.Buttons.marginTop)
            .left(Constants.Buttons.marginHorizontal)
            .size(Constants.Buttons.size.width)
        
        signWithVKButton.pin
            .top(Constants.Buttons.marginTop)
            .after(of: signWithGoogleButton)
            .marginLeft(spacing)
            .size(Constants.Buttons.size.width)
        
        signWithAnonymButton.pin
            .top(Constants.Buttons.marginTop)
            .after(of: signWithVKButton)
            .marginLeft(spacing)
            .size(Constants.Buttons.size.width)
        
        firstSeparator.pin
            .below(of: signWithGoogleButton)
            .marginTop(Constants.Separators.marginTop)
            .left(spacing)
            .width(Constants.Separators.size.width)
            .height(Constants.Separators.size.height)
        
        separatorLabel.pin
            .after(of: firstSeparator, aligned: .center)
            .marginLeft(Constants.Separators.marginLeft)
            
        secondSeparator.pin
            .after(of: separatorLabel, aligned: .center)
            .marginLeft(Constants.Separators.marginLeft)
            .width(Constants.Separators.size.width)
            .height(Constants.Separators.size.height)
        
        emailTextField.pin
            .below(of: separatorLabel)
            .marginTop(Constants.TextField.emailMarginTop)
            .hCenter()
            .width(elementWidth)
        
        emailUnderline.pin
            .below(of: emailTextField)
            .marginTop(Constants.Underline.marginTop)
            .hCenter()
            .width(elementWidth)
            .height(Constants.Underline.sizeHeight)
        
        passwordTextField.pin
            .below(of: emailUnderline)
            .marginTop(Constants.TextField.passwordMarginTop)
            .hCenter()
            .width(elementWidth)
        
        passwordUnderline.pin
            .below(of: passwordTextField)
            .marginTop(Constants.Underline.marginTop)
            .hCenter()
            .width(elementWidth)
            .height(Constants.Underline.sizeHeight)
        
        togglePasswordButton.pin
            .size(Constants.Buttons.togglePasswordButtonSize)
            .right()
            .vCenter()
            
        signUpButton.pin
            .below(of: passwordUnderline)
            .marginTop(Constants.Buttons.signUpMarginTop)
            .hCenter()
            .width(elementWidth)
            .height(Constants.Buttons.signUpHeight)
        
        privacyPolicyLabel.pin
            .below(of: signUpButton)
            .marginTop(Constants.Link.marginTop)
            .hCenter()
            .height(Constants.Link.sizeHeight)
            .width(elementWidth)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapSignWithGoogleButton() {
        animateButton(with: signWithGoogleButton)
        output.didTapSignWithGoogleButton()
    }
    
    @objc
    private func didTapSignWithVKButton() {
        animateButton(with: signWithVKButton)
        output.didTapSignWithVKButton()
    }
    
    @objc
    private func didTapSignWithAnonymButton() {
        animateButton(with: signWithAnonymButton)
        output.didTapSignWithAnonymButton()
    }
    
    @objc
    private func didTapSignUpButton() {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        animateButton(with: signUpButton)
        output.didTapSignUpButton(with: email, and: password)
    }
    
    @objc
    private func didTapOnPrivacyPolicy() {
    }
    
    @objc
    private func didTapShowPasswordButton() {
        passwordTextField.isSecureTextEntry.toggle()
        let isOpen = !passwordTextField.isSecureTextEntry
        (passwordTextField.rightView as? UIButton)?.isSelected = isOpen
    }
    
    @objc
    private func didTapDoneButton() {
        view.endEditing(true)
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

// MARK: - SignUpViewInput

extension SignUpViewController: SignUpViewInput {
    func showAlert(with key: String, message: String) {
        switch key {
        case "email":
            AlertManager.showInvalidEmailAlert(on: self)
        case "password":
            AlertManager.showInvalidPasswordAlert(on: self, message: message.localized)
        case "network":
            AlertManager.showRegistrationErrorAlert(on: self, message: message.localized)
        case "signed":
            AlertManager.showSignedUpAlert(on: self, message: message.localized)
        default:
            let error = NSError(domain: "Everydaytech.ru", code: 400)
            AlertManager.showRegistrationErrorAlert(on: self, with: error)
        }
    }
    
    func configure(with model: SignUpViewModel) {
        signWithGoogleButton.setImage(model.googleImage, for: .normal)
        signWithVKButton.setImage(model.vkImage, for: .normal)
        signWithAnonymButton.setImage(model.anonymImage, for: .normal)
        
        separatorLabel.attributedText = model.separatorTitle
        
        emailTextField.attributedPlaceholder = model.emailTitle
        passwordTextField.attributedPlaceholder = model.passwordTitle
        
        signUpButton.setAttributedTitle(model.signUpTitle, for: .normal)
        
        privacyPolicyLabel.attributedText = model.privacyPolicyLabel
        
        togglePasswordButton.setImage(model.showPasswordImage, for: .selected)
        togglePasswordButton.setImage(model.hidePasswordImage, for: .normal)
    }
}

// MARK: - Constants

private extension SignUpViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.UI.accentLight
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.grayElement
        
        struct Buttons {
            static let size: CGSize = CGSize(width: 60, height: 60)
            static let marginHorizontal: CGFloat = 40
            static let marginTop: CGFloat = 20
            static let cornerRadius: CGFloat = 30
            static let transform: CGFloat = 0.9
            static let transformDuration: CGFloat = 0.1
            
            static let signUpHeight: CGFloat = 60
            static let signUpCornerRadius: CGFloat = 20
            static let signUpMarginTop: CGFloat = 35
            static let togglePasswordButtonSize: CGFloat = 40
        }
        
        struct Separators {
            static let size: CGSize = CGSize(width: 95, height: 1)
            static let borderWidth: CGFloat = 1.0
            static let marginTop: CGFloat = 35
            static let marginLeft: CGFloat = 20
        }
        
        struct TextField {
            static let emailMarginTop: CGFloat = 20
            static let passwordMarginTop: CGFloat = 35 / 1.2
            static let marginLeft: CGFloat = 20
        }
        
        struct Underline {
            static let sizeHeight: CGFloat = 1
            static let borderWidth: CGFloat = 1.0
            static let  marginTop: CGFloat = 4
        }
        
        struct Link {
            static let marginTop: CGFloat = 20
            static let sizeHeight: CGFloat = 40
        }
    }
}
