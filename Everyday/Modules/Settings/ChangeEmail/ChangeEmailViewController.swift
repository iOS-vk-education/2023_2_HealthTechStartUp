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
    private let forgotPasswordButton = UIButton(type: .custom)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let navBarTitle = UILabel()
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
        
        view.backgroundColor = Constants.backgroundColor
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        self.view.addGestureRecognizer(swipeRight)
        
        navBarTitle.attributedText = ChangeEmailViewModel().changeEmailTitle
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

private extension ChangeEmailViewController {
    
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
        contentView.addSubviews(newEmailField, passwordField, confirmButton, forgotPasswordButton)
    }
    
    func setupFields() {
        newEmailField.attributedPlaceholder = ChangeEmailViewModel().newEmailFieldTitle
        passwordField.attributedPlaceholder = ChangeEmailViewModel().passwordFieldTitle
                
        [newEmailField, passwordField].forEach { field in
            let leftView = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: 10,
                                                height: 0))
            
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
        confirmButton.setAttributedTitle(ChangeEmailViewModel().confirmButtonTitle, for: .normal)
        confirmButton.layer.cornerRadius = Constants.cornerRadius
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
    }
    
    // MARK: - Actions

    @objc
    func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            output.getBack()
        }
    }
}

extension ChangeEmailViewController: ChangeEmailViewInput {
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
            static let matginBottom: CGFloat = 50
            static let height: CGFloat = 50
        }
    }
}
