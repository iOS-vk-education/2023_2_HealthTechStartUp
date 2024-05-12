//
//  AuthorizationViewController.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//
//

import UIKit

final class AuthorizationViewController: UIViewController {
    // MARK: - private properties
    
    private let output: AuthorizationViewOutput
    private let signWithGoogleButton = UIButton(type: .custom)
    private let signWithVKButton     = UIButton(type: .custom)
    private let signWithAppleButton  = UIButton(type: .custom)
    private let signWithEmailButton  = UIButton(type: .custom)
    private let firstSeparator       = UIView()
    private let secondSeparator      = UIView()
    private let separatorLabel       = UILabel()
    private let privacyPolicyLabel   = UILabel()
   
    // MARK: - lifecycle
    
    init(output: AuthorizationViewOutput) {
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
        
        view.addSubviews(signWithGoogleButton, signWithVKButton, signWithAppleButton,
                         firstSeparator, separatorLabel, secondSeparator,
                         signWithEmailButton, privacyPolicyLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - setup
    
    private func setup() {
        setupButtons()
        setupSeparators()
        setupLabels()
    }
    
    private func setupButtons() {
        for button in [signWithGoogleButton, signWithVKButton, signWithAppleButton] {
            button.clipsToBounds = true
            button.layer.cornerRadius = Constants.Buttons.cornerRadius
        }
        
        signWithEmailButton.layer.cornerRadius = Constants.Buttons.signWithEmaiCornerRadius
        signWithEmailButton.backgroundColor = Constants.accentColor
        
        signWithGoogleButton.addTarget(self, action: #selector(didTapSignWithGoogleButton), for: .touchUpInside)
        signWithVKButton.addTarget(self, action: #selector(didTapSignWithVKButton), for: .touchUpInside)
        signWithAppleButton.addTarget(self, action: #selector(didTapSignWithAppleButton), for: .touchUpInside)
        signWithEmailButton.addTarget(self, action: #selector(didTapSignWithEmailButton), for: .touchUpInside)
    }
    
    private func setupSeparators() {
        for separator in [firstSeparator, secondSeparator] {
            separator.layer.borderWidth = Constants.Separators.borderWidth
            separator.layer.borderColor = UIColor.Text.grayElement.cgColor
        }
    }
    
    private func setupLabels() {
        separatorLabel.sizeToFit()
        
        privacyPolicyLabel.isUserInteractionEnabled = true
        privacyPolicyLabel.numberOfLines = 0
        privacyPolicyLabel.textAlignment = .center
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
        
        signWithAppleButton.pin
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
        
        signWithEmailButton.pin
            .below(of: separatorLabel)
            .marginTop(Constants.Buttons.signWithEmaiMarginTop)
            .hCenter()
            .width(elementWidth)
            .height(Constants.Buttons.signWithEmailHeight)
        
        privacyPolicyLabel.pin
            .below(of: signWithEmailButton)
            .marginTop(Constants.Link.marginTop)
            .hCenter()
            .height(Constants.Link.sizeHeight)
            .width(elementWidth)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapSignWithGoogleButton() {
        animateButton(with: signWithGoogleButton)
        output.didTapSignInWithGoogleButton()
    }
    
    @objc
    private func didTapSignWithVKButton() {
        animateButton(with: signWithVKButton)
        output.didTapSignInWithVKButton()
    }
    
    @objc
    private func didTapSignWithAppleButton() {
        animateButton(with: signWithAppleButton)
        output.didTapSignInWithAppleButton()
    }
    
    @objc
    private func didTapSignWithEmailButton() {
        animateButton(with: signWithEmailButton)
        output.didTapSignInWithEmailButton()
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

// MARK: - View input

extension AuthorizationViewController: AuthorizationViewInput {
    func showAlert(with type: AlertType) {
        AlertService.shared.presentAlert(on: self, alertType: type)
    }
    
    func configure(with model: AuthorizationViewModel) {
        signWithGoogleButton.setImage(model.googleImage, for: .normal)
        signWithVKButton.setImage(model.vkImage, for: .normal)
        signWithAppleButton.setImage(model.appleImage, for: .normal)
        signWithEmailButton.setAttributedTitle(model.emailTitle, for: .normal)
        
        separatorLabel.attributedText = model.separatorTitle
        
        privacyPolicyLabel.attributedText = model.privacyPolicyLabel
    }
}

// MARK: - Constants

private extension AuthorizationViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        static let textColor: UIColor = UIColor.Text.grayElement
        static let accentColor: UIColor = UIColor.UI.accent
        
        struct Buttons {
            static let size: CGSize = CGSize(width: 60, height: 60)
            static let marginHorizontal: CGFloat = 40
            static let marginTop: CGFloat = 14
            static let cornerRadius: CGFloat = 30
            static let transform: CGFloat = 0.9
            static let transformDuration: CGFloat = 0.1
            
            static let signWithEmailHeight: CGFloat = 60
            static let signWithEmaiCornerRadius: CGFloat = 20
            static let signWithEmaiMarginTop: CGFloat = 20
        }
        
        struct Separators {
            static let size: CGSize = CGSize(width: 95, height: 1)
            static let borderWidth: CGFloat = 1.0
            static let marginTop: CGFloat = 20
            static let marginLeft: CGFloat = 20
        }
        
        struct Link {
            static let marginTop: CGFloat = 14
            static let sizeHeight: CGFloat = 40
        }
    }
}
