//
//  ForgotPasswordViewController.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//

import UIKit
import PinLayout

final class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let emailTextField = UITextField()
    private let continueButton = UIButton()
    
    private let authService: AuthServiceDescription
    private var activeTextField: UITextField?
    
    // MARK: - Life cycle
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
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
        setupWithModel()
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
        contentView.addSubviews(titleLabel, emailTextField, continueButton)
    }
    
    private func setupLabel() {
        titleLabel.textAlignment = .center
    }
    
    private func setupTextFields() {
        emailTextField.textColor = Constants.textColor
        emailTextField.autocapitalizationType = .none
        emailTextField.tintColor = Constants.accentColor
        emailTextField.autocorrectionType = .no
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.TextField.textAlignerWidth, height: emailTextField.frame.height))
        emailTextField.layer.cornerRadius = Constants.TextField.cornerRadius
        emailTextField.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
        emailTextField.keyboardType = .emailAddress
    }
    
    private func setupButtons() {
        continueButton.clipsToBounds = true
        continueButton.layer.cornerRadius = Constants.Buttons.cornerRadius
        continueButton.backgroundColor = Constants.accentColor
        
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
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
        
        continueButton.pin
            .bottom(view.pin.safeArea.bottom)
            .hCenter()
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.height)
    }
}

// MARK: - Private functions

extension ForgotPasswordViewController {
    private func setupWithModel() {
        let viewModel = ForgotPasswordViewModel()
        
        titleLabel.attributedText = viewModel.titleLabelText
        emailTextField.attributedPlaceholder = viewModel.emailTextFieldPlaceholder
        continueButton.setAttributedTitle(viewModel.continueButtonTitle, for: .normal)
    }
    
    private func openApp() {
        guard let navigationController = self.navigationController else {
            fatalError("SignInViewController is not embedded in a navigation controller.")
        }
           
       let tabBarController = TabBarController()
       tabBarController.modalPresentationStyle = .fullScreen

        UIView.transition(with: navigationController.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            navigationController.setViewControllers([tabBarController], animated: false)
        }, completion: nil)
    }
}

// MARK: - Actions

extension ForgotPasswordViewController {
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let buttonBottomMargin: CGFloat = Constants.TextField.passwordBottom

        let newButtonBottom = self.view.frame.height - keyboardHeight - buttonBottomMargin
        
        self.continueButton.pin
            .bottom(newButtonBottom)
            .hCenter()
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.height)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.continueButton.pin
                .bottom(self.view.frame.height - self.view.safeAreaInsets.bottom)
                .hCenter()
                .width(Constants.Buttons.width)
                .height(Constants.Buttons.height)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func didTapContinueButton() {
        animateButton(with: continueButton)
        let email = self.emailTextField.text ?? ""
        
        guard Validator.isValidEmail(for: email) else {
            AlertService.shared.presentAlert(on: self, alertType: .invalidEmail)
            return
        }
        
        authService.forgotPassword(with: email) { result in
            switch result {
            case .success:
                AlertService.shared.presentInfo(on: self, alertType: .sendResetLink)
                self.openApp()
            case .failure(let error):
                AlertService.shared.presentAlert(on: self, alertType: .networkMessage(error: error))
            }
        }
    }
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
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

// MARK: - Constants

extension ForgotPasswordViewController {
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
            static let passwordBottom: CGFloat = 154
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
