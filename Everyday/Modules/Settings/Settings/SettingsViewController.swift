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
        
        view.backgroundColor = .systemMint
        
        view.addSubview(logoutButton)
        
        setup()
    }
    
    func setup() {
        logoutButton.setTitle("logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    func didTapLogoutButton() {
        let authService = AuthService.shared
        authService.logout { result in
            switch result {
            case .success:
              Reloader.shared.setLogout()
                print("ok")
            case .failure:
                print("ne ok")
            }
        }
    }
}

extension SettingsViewController: SettingsViewInput {
}
