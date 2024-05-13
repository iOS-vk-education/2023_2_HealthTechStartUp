//
//  HealthProtocols.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//  
//

import Foundation

protocol HealthModuleInput {
    var moduleOutput: HealthModuleOutput? { get }
}

protocol HealthModuleOutput: AnyObject {
}

protocol HealthViewInput: AnyObject {
    func configure(with: HealthViewModel)
}

protocol HealthViewOutput: AnyObject {
    func healthKitIsAvaible() -> Bool
    func didLoadView()
    func getHealthViewModel() -> HealthViewModel
    func didSwipe()
}

protocol HealthInteractorInput: AnyObject {
}

protocol HealthInteractorOutput: AnyObject {
}

protocol HealthRouterInput: AnyObject {
    func getBackToMainView()
}
