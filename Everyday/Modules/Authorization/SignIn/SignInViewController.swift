//
//  SignInViewController.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: SignInViewOutput
    private let signWithGoogleButton = UIButton(type: .custom)
    private let signWithVKButton     = UIButton(type: .custom)
    private let signWithAnonymButton = UIButton(type: .custom)
    private let signInButton         = UIButton(type: .system)
    private let togglePasswordButton = UIButton(type: .custom)
    private let firstSeparator       = UIView()
    private let secondSeparator      = UIView()
    private let emailUnderline       = UIView()
    private let passwordUnderline    = UIView()
    private let separatorLabel       = UILabel()
    private let forgotPasswordLabel  = UILabel()
    private let emailTextField       = UITextField()
    private let passwordTextField    = UITextField()
    
    // MARK: - lifecycle
    
    init(output: SignInViewOutput) {
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnForgotPassword))
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
                
        view.addSubviews(signWithGoogleButton, signWithVKButton, signWithAnonymButton,
                         firstSeparator, secondSeparator, separatorLabel,
                         emailTextField, emailUnderline,
                         passwordTextField, passwordUnderline, togglePasswordButton,
                         signInButton,
                         forgotPasswordLabel)
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
    }

    private func setupButtons() {
        for button in [signWithGoogleButton, signWithVKButton, signWithAnonymButton] {
            button.clipsToBounds = true
            button.layer.cornerRadius = Constants.Buttons.cornerRadius
        }
        
        signInButton.layer.cornerRadius = Constants.Buttons.signUpCornerRadius
        signInButton.backgroundColor = Constants.accentColor
        
        togglePasswordButton.contentMode = .scaleAspectFill
        togglePasswordButton.tintColor = Constants.accentColor
        
        signWithGoogleButton.addTarget(self, action: #selector(didTapSignWithGoogleButton), for: .touchUpInside)
        signWithVKButton.addTarget(self, action: #selector(didTapSignWithVKButton), for: .touchUpInside)
        signWithAnonymButton.addTarget(self, action: #selector(didTapSignWithAnonymButton), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        togglePasswordButton.addTarget(self, action: #selector(didTapShowPasswordButton), for: .touchUpInside)
    }

    private func setupLines() {
        for separator in [firstSeparator, secondSeparator] {
            separator.layer.borderWidth = Constants.Separators.borderWidth
            separator.layer.borderColor = UIColor.Text.primary.cgColor
        }
        
        for line in [emailUnderline, passwordUnderline] {
            line.layer.borderWidth = Constants.Underline.borderWidth
            line.layer.borderColor = UIColor.Text.primary.cgColor
        }
    }

    private func setupLabels() {
        separatorLabel.sizeToFit()
        
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.numberOfLines = 0
        forgotPasswordLabel.textAlignment = .center
    }

    private func setupTextField() {
        for field in [emailTextField, passwordTextField] {
            field.borderStyle = .none
            field.sizeToFit()
            field.textColor = Constants.textColor
            field.autocapitalizationType = .none
            field.tintColor = Constants.accentColor
        }
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = togglePasswordButton
        passwordTextField.rightViewMode = .always
    }

    // MARK: - Layout

    private func layout() {
        let spacing = (((view.frame.width - Constants.Buttons.size.width * 3 - Constants.Buttons.marginHorizontal * 2) / 2) * 100).rounded() / 100
        let elementWidth = Constants.Buttons.size.width * 3 + 2 * spacing
        
        emailTextField.pin
            .top(Constants.TextField.emailMarginTop)
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
        
        signInButton.pin
            .below(of: passwordUnderline)
            .marginTop(Constants.Buttons.signUpMarginTop)
            .hCenter()
            .width(elementWidth)
            .height(Constants.Buttons.signUpHeight)

        forgotPasswordLabel.pin
            .below(of: signInButton)
            .marginTop(Constants.Link.marginTop)
            .hCenter()
            .height(Constants.Link.sizeHeight)
            .width(elementWidth)
        
        firstSeparator.pin
            .below(of: forgotPasswordLabel)
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
        
        signWithGoogleButton.pin
            .below(of: secondSeparator)
            .marginTop(Constants.Buttons.marginTop)
            .left(Constants.Buttons.marginHorizontal)
            .size(Constants.Buttons.size.width)
        
        signWithVKButton.pin
            .after(of: signWithGoogleButton, aligned: .center)
            .marginLeft(spacing)
            .size(Constants.Buttons.size.width)
        
        signWithAnonymButton.pin
            .after(of: signWithVKButton, aligned: .center)
            .marginLeft(spacing)
            .size(Constants.Buttons.size.width)
    }

    // MARK: - Actions

    @objc
    private func didTapSignWithGoogleButton() {
        animateButton(with: signWithGoogleButton)
    }

    @objc
    private func didTapSignWithVKButton() {
        animateButton(with: signWithVKButton)
    }

    @objc
    private func didTapSignWithAnonymButton() {
        animateButton(with: signWithAnonymButton)
    }

    @objc
    private func didTapSignInButton() {
        animateButton(with: signInButton)
    }

    @objc
    private func didTapOnForgotPassword() {
    }

    @objc
    private func didTapShowPasswordButton() {
        passwordTextField.isSecureTextEntry.toggle()
        let isOpen = !passwordTextField.isSecureTextEntry
        (passwordTextField.rightView as? UIButton)?.isSelected = isOpen
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

extension SignInViewController: SignInViewInput {
    func configure(with model: SignInViewModel) {
        signWithGoogleButton.setImage(model.googleImage, for: .normal)
        signWithVKButton.setImage(model.vkImage, for: .normal)
        signWithAnonymButton.setImage(model.anonymImage, for: .normal)
        
        separatorLabel.attributedText = model.separatorTitle
        
        emailTextField.attributedPlaceholder = model.emailTitle
        passwordTextField.attributedPlaceholder = model.passwordTitle
        
        signInButton.setAttributedTitle(model.signInTitle, for: .normal)
        
        forgotPasswordLabel.attributedText = model.forgotPasswordLabel
        
        togglePasswordButton.setImage(model.showPasswordImage, for: .selected)
        togglePasswordButton.setImage(model.hidePasswordImage, for: .normal)
    }
}

// MARK: - Constants

private extension SignInViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.UI.accentLight
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        
        struct Buttons {
            static let size: CGSize = CGSize(width: 60, height: 60)
            static let marginHorizontal: CGFloat = 40
            static let marginTop: CGFloat = 35
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
            static let marginTop: CGFloat = 20
            static let marginLeft: CGFloat = 20
        }
        
        struct TextField {
            static let emailMarginTop: CGFloat = 25
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
