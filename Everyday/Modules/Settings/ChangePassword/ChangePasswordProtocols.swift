//
//  ChangePasswordProtocols.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

protocol ChangePasswordModuleInput {
    var moduleOutput: ChangePasswordModuleOutput? { get }
}

protocol ChangePasswordModuleOutput: AnyObject {
}

protocol ChangePasswordViewInput: AnyObject {
    func showAlert(with key: String, message: String)
    func configure(with: ChangePasswordViewModel)
}

protocol ChangePasswordViewOutput: AnyObject {
    func didTapConfirmButton(with oldPassword: String?, and newPassword: String?)
    func didLoadView()
    func getBack()
}

protocol ChangePasswordInteractorInput: AnyObject {
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol ChangePasswordInteractorOutput: AnyObject {
}

protocol ChangePasswordRouterInput: AnyObject {
    func getBackToMainView()
}
