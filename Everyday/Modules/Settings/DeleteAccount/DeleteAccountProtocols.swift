//
//  DeleteAccountProtocols.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

protocol DeleteAccountModuleInput {
    var moduleOutput: DeleteAccountModuleOutput? { get }
}

protocol DeleteAccountModuleOutput: AnyObject {
}

protocol DeleteAccountViewInput: AnyObject {
    func showAlert(with key: String, message: String)
    func configure(with: DeleteAccountViewModel)
}

protocol DeleteAccountViewOutput: AnyObject {
    func didTapConfirmButton(with email: String?, and password: String?)
    func didLoadView()
    func getBack()
}

protocol DeleteAccountInteractorInput: AnyObject {
    func deleteAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol DeleteAccountInteractorOutput: AnyObject {
}

protocol DeleteAccountRouterInput: AnyObject {
    func routeToAuthentication()
    func getBackToMainView()
}
