//
//  SettingsViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class SettingsViewController: UIViewController {
    private let output: SettingsViewOutput
    private let logoutButton = UIButton(type: .system)

    init(output: SettingsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        output.didLoadView()
        setupUI()
        
        view.addSubviews(logoutButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    // MARK: - Setup
    
    private func setupUI() {
        logoutButton.contentMode = .scaleAspectFill
        
        logoutButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }
    
    private func layout() {
        logoutButton.pin
            .hCenter()
            .vCenter()
            .width(Constants.Buttons.size.width)
            .height(Constants.Buttons.size.height)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapSignInButton() {
        output.didTapLogoutButton()
    }
}

extension SettingsViewController: SettingsViewInput {
    func configure(with model: SettingsViewModel) {
        logoutButton.setAttributedTitle(model.logoutTitle, for: .normal)
    }
    
    func showAlert() {
        let error = NSError(domain: "Everydaytech.ru", code: 400)
        AlertManager.showLogoutError(on: self, with: error)
    }
}

// MARK: - Constants

private extension SettingsViewController {
    struct Constants {
        struct Buttons {
            static let size: CGSize = CGSize(width: 60, height: 60)
            static let cornerRadius: CGFloat = 30
            static let transform: CGFloat = 0.9
            static let transformDuration: CGFloat = 0.1
        }
    }
}
