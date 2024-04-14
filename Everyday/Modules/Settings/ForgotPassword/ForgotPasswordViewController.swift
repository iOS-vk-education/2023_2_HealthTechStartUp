//
//  ForgotPasswordViewController.swift
//  Everyday
//
//  Created by Yaz on 14.04.2024.
//

import UIKit
import PinLayout

final class ForgotPasswordViewController: UIViewController {
    private let output: ForgotPasswordViewOutput
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let emailField = UITextField()
    private let confirmButton = UIButton()
    let navBarTitle = UILabel()
    
    init(output: ForgotPasswordViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    //    ForgotPassword
    
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
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        self.view.addGestureRecognizer(swipeRight)
        
        self.navigationItem.titleView = navBarTitle
        navigationController?.navigationBar.tintColor = Constants.accentColor
        
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(scrollView)
        
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        layout()
    }
}
// MARK: - Setup

private extension ForgotPasswordViewController {
    
    func setup() {
        setupScrollView()
        setupContentView()
        setupField()
        setupButton()
    }
    
    func setupScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func setupContentView() {
        contentView.addSubviews(emailField, confirmButton)
    }
    
    func setupField() {
        let leftView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 10,
                                            height: 0))
        emailField.autocapitalizationType = .none
        emailField.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
        emailField.layer.cornerRadius = Constants.cornerRadius
        emailField.attributedPlaceholder = NSAttributedString(
            string: emailField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        emailField.leftView = leftView
        emailField.leftViewMode = .always
    }
    
    func setupButton() {
        confirmButton.backgroundColor = Constants.gray.withAlphaComponent(Constants.TextField.colorOpacity)
        confirmButton.layer.cornerRadius = Constants.cornerRadius
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
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
        
        emailField.pin
            .left()
            .right()
            .top(to: contentView.edge.top)
            .height(Constants.TextField.height)
            .marginTop(Constants.TextField.marginTop)
            .marginRight(Constants.TextField.margin)
            .marginLeft(Constants.TextField.margin)
        
        confirmButton.pin
            .left()
            .right()
            .top(to: emailField.edge.bottom)
            .height(Constants.Button.height)
            .marginTop(Constants.Button.marginTop)
            .marginRight(Constants.Button.margin)
            .marginLeft(Constants.Button.margin)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapWholeView() {
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
        let email = self.emailField.text ?? ""
        output.didTapConfirmButton(with: email)
    }
}

// MARK: - ChangeEmailViewInput

extension ForgotPasswordViewController: ForgotPasswordViewInput {
    func showAlert(with key: String, message: String) {
    }
    
    func configure(with model: ForgotPasswordViewModel) {
        navBarTitle.attributedText = model.forgotPasswordTitle
        emailField.attributedPlaceholder = model.emailFieldTitle
        confirmButton.setAttributedTitle(model.confirmButtonTitle, for: .normal)
    }
}

// MARK: - Constants

private extension ForgotPasswordViewController {
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
            static let matginBottom: CGFloat = 50
            static let height: CGFloat = 50
        }
    }
}
