//
//  AlertService.swift
//  Everyday
//
//  Created by Михаил on 22.04.2024.
//

import UIKit
import SwiftUI
import PinLayout

final class AlertService {
    static let shared = AlertService()

    private init() {}

    func presentAlert(on viewController: UIViewController, alertType: AlertType) {
        let viewModel = AlertServiceViewModel(alertType: alertType)
        let alertViewController = AlertViewController(viewModel: viewModel)

        alertViewController.modalPresentationStyle = .overFullScreen
        viewController.present(alertViewController, animated: false, completion: nil)

        HapticService.shared.vibrate(for: .warning)
    }

    func presentInfo(on viewController: UIViewController, alertType: AlertType) {
        let viewModel = AlertServiceViewModel(alertType: alertType)
        let alertViewController = AlertViewController(viewModel: viewModel)

        alertViewController.modalPresentationStyle = .overFullScreen
        viewController.present(alertViewController, animated: false, completion: nil)

        HapticService.shared.vibrate(for: .success)
    }
}

struct AlertViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var alertType: AlertType

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            DispatchQueue.main.async {
                let _: () = AlertService.shared.presentAlert(on: uiViewController, alertType: alertType)
                isPresented = false
            }
        }
    }
}

final class AlertViewController: UIViewController {

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
            label.numberOfLines = Constants.Label.numberOfLines
            label.textAlignment = .left
        }
    }

    func setupButton() {
        let closeButtonConfig = UIImage.SymbolConfiguration(pointSize: Constants.CloseButton.pointSize, weight: .regular)
        let image = UIImage(systemName: "xmark", withConfiguration: closeButtonConfig)

        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = Constants.closeButtonColor
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        closeButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)

        button.setAttributedTitle(viewModel.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        button.backgroundColor = Constants.accentColor
        button.layer.cornerRadius = Constants.Button.cornerRadius
    }

    func setupPopupView() {
        popupView.backgroundColor = Constants.backgroundColor
        popupView.layer.cornerRadius = Constants.PopupView.cornerRadius
        popupView.clipsToBounds = true
    }

    // MARK: - layout

    func layout() {
        popupView.pin
            .top()
            .horizontally()

        closeButton.pin
            .size(Constants.CloseButton.size)

        titleLabel.pin
            .below(of: closeButton)
            .width(Constants.Label.width)
            .height(Constants.Label.height)
            .sizeToFit(.width)

        descriptionLabel.pin
            .below(of: titleLabel, aligned: .left)
            .marginTop(Constants.Label.descriptionMarginTop)
            .width(Constants.Label.width)
            .height(Constants.Label.height)
            .sizeToFit(.width)

        button.pin
            .below(of: descriptionLabel)
            .marginTop(Constants.Button.marginTop)
            .size(Constants.Button.size)

        popupView.pin
            .wrapContent(padding: Constants.PopupView.padding)
            .vCenter()
            .hCenter()

        closeButton.pin
            .top(Constants.CloseButton.top)
            .right(Constants.CloseButton.right)

        titleLabel.pin
            .marginTop(Constants.Label.titleMarginTop)
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

        struct Button {
            static let cornerRadius: CGFloat = 10
            static let size: CGSize = CGSize(width: 250, height: 50)
            static let marginTop: CGFloat = 10
        }

        struct CloseButton {
            static let size: CGSize = CGSize(width: 14, height: 12)
            static let top: CGFloat = 10
            static let right: CGFloat = 10
            static let pointSize: CGFloat = 20
        }

        struct PopupView {
            static let cornerRadius: CGFloat = 10
            static let padding: CGFloat = 20
        }

        struct Label {
            static let height: CGFloat = 100
            static let width: CGFloat = 250
            static let titleMarginTop: CGFloat = 5
            static let descriptionMarginTop: CGFloat = 4
            static let numberOfLines: Int = 0
        }
    }
}
