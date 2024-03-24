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
}

protocol DeleteAccountViewOutput: AnyObject {
    func getBack()
}

protocol DeleteAccountInteractorInput: AnyObject {
}

protocol DeleteAccountInteractorOutput: AnyObject {
}

protocol DeleteAccountRouterInput: AnyObject {
    func getBackToMainView()
}
