//
//  SettingsProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

protocol SettingsModuleInput {
    var moduleOutput: SettingsModuleOutput? { get }
}

protocol SettingsModuleOutput: AnyObject {
}

protocol SettingsViewInput: AnyObject {
    func configure(with: SettingsViewModel)
    func showAlert()
}

protocol SettingsViewOutput: AnyObject {
    func didLoadView()
    func didTapLogoutButton()
}

protocol SettingsInteractorInput: AnyObject {
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
}

protocol SettingsInteractorOutput: AnyObject {
}

protocol SettingsRouterInput: AnyObject {
    func routeToAuthentication()
}
