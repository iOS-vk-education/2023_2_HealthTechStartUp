//
//  UnitsProtocols.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

protocol UnitsModuleInput {
    var moduleOutput: UnitsModuleOutput? { get }
}

protocol UnitsModuleOutput: AnyObject {
}

protocol UnitsViewInput: AnyObject {
    func configure(with: UnitsViewModel)
    func showAlert(with key: String, message: String)
}

protocol UnitsViewOutput: AnyObject {
    func didLoadView()
    func getUnitsViewModel() -> UnitsViewModel
    func didSwipe()
}

protocol UnitsInteractorInput: AnyObject {
}

protocol UnitsInteractorOutput: AnyObject {
}

protocol UnitsRouterInput: AnyObject {
    func getBackToMainView()
}
