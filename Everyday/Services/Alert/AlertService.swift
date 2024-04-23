//
//  AlertService.swift
//  Everyday
//
//  Created by Михаил on 22.04.2024.
//

import UIKit
import PinLayout

class AlertService {
    static let shared = AlertService()

    private init() {}

    func presentAlert(on viewController: UIViewController, alertType: AlertType) {
        let viewModel = AlertServiceViewModel(alertType: alertType)
        let alertViewController = AlertViewController(viewModel: viewModel)
        
        alertViewController.modalPresentationStyle = .overFullScreen
        viewController.present(alertViewController, animated: false, completion: nil)
        
        HapticService.shared.vibrate(for: .warning)
    }
}

class AlertViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: AlertServiceViewModel
    private let popupView = UIView()
    private let visualEffectView = UIVisualEffectView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    private let closeButton = CloseButton()

    // MARK: - Lifecycle

    init(viewModel: AlertServiceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        view.addSubviews(visualEffectView, popupView)
        popupView.addSubviews(closeButton, titleLabel, descriptionLabel, button)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePopupAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }

    // MARK: - setup
    
    func setup() {
        setupBackground()
        setupPopupView()
        setupButton()
        setupLabels()
    }
    
    func setupBackground() {
        let blurEffect = UIBlurEffect(style: .dark)
        visualEffectView.effect = blurEffect
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setupLabels() {
        titleLabel.attributedText = viewModel.labelTitle
        descriptionLabel.attributedText = viewModel.labelDescription
        
        for label in [titleLabel, descriptionLabel] {
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.textAlignment = .left
        }
    }
    
    func setupButton() {
        let closeButtonConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: closeButtonConfig)
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = Constants.closeButtonColor
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        closeButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        button.setAttributedTitle(viewModel.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        button.backgroundColor = Constants.accentColor
        button.layer.cornerRadius = 10
    }
    
    func setupPopupView() {
        popupView.backgroundColor = Constants.backgroundColor
        popupView.layer.cornerRadius = 10
        popupView.clipsToBounds = true
    }
    
    // MARK: - layout
    
    func layout() {
        popupView.pin
            .top()
            .horizontally()
            
        closeButton.pin
            .size(CGSize(width: 14, height: 12))
        
        titleLabel.pin
            .below(of: closeButton)
            .width(250)
            .height(100)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: titleLabel, aligned: .left)
            .marginTop(4)
            .width(250)
            .height(100)
            .sizeToFit(.width)
        
        button.pin
            .below(of: descriptionLabel)
            .marginTop(10)
            .size(CGSize(width: 250, height: 50))
        
        popupView.pin
            .wrapContent(padding: 20)
            .vCenter()
            .hCenter()
        
        closeButton.pin
            .top(10)
            .right(10)
        
        titleLabel.pin
            .marginTop(5)
            .hCenter()
        
        button.pin
            .hCenter()
    }
    
    // MARK: - animation
    
    func animatePopupAppearance() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    // MARK: - actions

    @objc func dismissAlert() {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - constants
private extension AlertViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        static let accentColor: UIColor = UIColor.UI.accent
        static let closeButtonColor: UIColor = UIColor.Text.grayElement
    }
}
