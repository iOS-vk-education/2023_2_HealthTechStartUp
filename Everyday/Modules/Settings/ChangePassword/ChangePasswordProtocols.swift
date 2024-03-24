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
}

protocol ChangePasswordViewOutput: AnyObject {
    func getBack()
}

protocol ChangePasswordInteractorInput: AnyObject {
}

protocol ChangePasswordInteractorOutput: AnyObject {
}

protocol ChangePasswordRouterInput: AnyObject {
    func getBackToMainView()
}
