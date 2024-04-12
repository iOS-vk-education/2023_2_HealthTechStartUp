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
}

protocol UnitsViewOutput: AnyObject {
    func didSwipe()
}

protocol UnitsInteractorInput: AnyObject {
}

protocol UnitsInteractorOutput: AnyObject {
}

protocol UnitsRouterInput: AnyObject {
    func getBackToMainView()
}
