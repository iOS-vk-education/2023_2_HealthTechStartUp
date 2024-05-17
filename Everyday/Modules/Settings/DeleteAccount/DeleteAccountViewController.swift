//
//  DeleteAccountViewController.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit
import PinLayout

final class DeleteAccountViewController: UIViewController {
    // MARK: - Private properties
    
    private let output: DeleteAccountViewOutput
    
    private let passwordField = UITextField()
    private let emailField = UITextField()
    private let confirmButton = UIButton()
    private let forgotPasswordButton = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let discriprionLabel = UILabel()
    private let navBarTitle = UILabel()
    init(output: DeleteAccountViewOutput) {
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
        switch output.getWhichSign() {
        case "vk", "google": layoutForOtherNonEmailSign()
        case "email": layoutForSignWithEmail()
        default:
            print("Sign method error")
        }
    }
}

private extension DeleteAccountViewController {
    
    // MARK: - Setup
    
    private func setup() {
        setupScrollView()
        setupContentView()
        setupFields()
        setupButtons()
        setupLabel()
    }
    
    private func setupScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupContentView() {
        contentView.addSubviews(emailField, passwordField, confirmButton, forgotPasswordButton, discriprionLabel)
    }
    
    private func setupFields() {
        [emailField, passwordField].forEach { field in
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

        if output.getWhichSign() == Constants.emailSignMethod {
            forgotPasswordButton.isHidden = false
        } else {
            forgotPasswordButton.isHidden = true
        }
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
    }
    
    private func setupLabel() {
        discriprionLabel.textAlignment = .center
        discriprionLabel.numberOfLines = .max
    }
    
    // MARK: - Layout
    
    private func layoutForSignWithEmail() {
        scrollView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
        
        contentView.pin
            .top(to: scrollView.edge.top)
            .horizontally()
            .bottom(to: scrollView.edge.bottom)
        
        emailField.pin
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
            .top(to: emailField.edge.bottom)
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
    
    private func layoutForOtherNonEmailSign() {
        scrollView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
        
        contentView.pin
            .top(to: scrollView.edge.top)
            .horizontally()
            .bottom(to: scrollView.edge.bottom)
        
        confirmButton.pin
            .left()
            .right()
            .top(to: contentView.edge.top)
            .height(Constants.Button.height)
            .marginTop(Constants.Button.marginTop)
            .marginRight(Constants.Button.margin)
            .marginLeft(Constants.Button.margin)
        
        discriprionLabel.pin
            .left()
            .right()
            .top(to: confirmButton.edge.bottom)
            .height(Constants.Label.height)
            .marginTop(Constants.Label.marginTop)
            .marginRight(Constants.Label.margin)
            .marginLeft(Constants.Label.margin)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapConfirmButton() {
        let email = self.emailField.text ?? ""
        let password = self.passwordField.text ?? ""
        
        output.didTapConfirmButton(with: email, and: password)
    }
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
    func didTapForgotPasswordButton() {
        output.didTapOnForgotPasswordButton()
    }
}

// MARK: - DeleteAccountViewInput

extension DeleteAccountViewController: DeleteAccountViewInput {
    func showAlert(with type: AlertType) {
        AlertService.shared.presentAlert(on: self, alertType: type)
    }
    
    func configure(with model: DeleteAccountViewModel) {
        navBarTitle.attributedText = model.deleteAcountTitle
        emailField.attributedPlaceholder = model.emailFielfTitle
        passwordField.attributedPlaceholder = model.passwordFieldTitle
        confirmButton.setAttributedTitle(model.deleteButtonTitle, for: .normal)
        discriprionLabel.attributedText = model.discriptionForDelete
        forgotPasswordButton.setAttributedTitle(model.forgotPasswordTitle, for: .normal)
    }
}

// MARK: - Constants

private extension DeleteAccountViewController {
    struct Constants {
        static let emailSignMethod: String = "email"
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
            static let marginBottom: CGFloat = 50
            static let height: CGFloat = 50
            static let width: CGFloat = 200
        }
        
        struct Button {
            static let margin: CGFloat = 20
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 60
            static let marginBottom: CGFloat = 50
            static let height: CGFloat = 50
            static let width: CGFloat = 200
        }
        
        struct Label {
            static let margin: CGFloat = 20
            static let marginTop: CGFloat = 20
            static let height: CGFloat = 100
        }
    }
}
