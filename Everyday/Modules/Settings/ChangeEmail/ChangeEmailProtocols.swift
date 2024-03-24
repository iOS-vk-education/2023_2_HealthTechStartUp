//
//  ChangeEmailProtocols.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

protocol ChangeEmailModuleInput {
    var moduleOutput: ChangeEmailModuleOutput? { get }
}

protocol ChangeEmailModuleOutput: AnyObject {
}

protocol ChangeEmailViewInput: AnyObject {
}

protocol ChangeEmailViewOutput: AnyObject {
    func getBack()
}

protocol ChangeEmailInteractorInput: AnyObject {
}

protocol ChangeEmailInteractorOutput: AnyObject {
}

protocol ChangeEmailRouterInput: AnyObject {
    func getBackToMainView()
}
