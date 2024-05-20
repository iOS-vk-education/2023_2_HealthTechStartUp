//
//  HealthPresenter.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//  
//

import Foundation

final class HealthPresenter {
    weak var view: HealthViewInput?
    weak var moduleOutput: HealthModuleOutput?
    
    private let router: HealthRouterInput
    private let interactor: HealthInteractorInput
    
    private let healthService = HealthService.shared
    
    init(router: HealthRouterInput, interactor: HealthInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HealthPresenter: HealthModuleInput {
}

extension HealthPresenter: HealthViewOutput {
    func healthKitIsAvaible() -> Bool {
        return healthService.isHealthKitAvaible()
    }
    
    func didLoadView() {
        let viewModel = HealthViewModel()
        view?.configure(with: viewModel)
    }
    
    func getHealthViewModel() -> HealthViewModel {
        let viewModel = HealthViewModel()
        return viewModel
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
}

extension HealthPresenter: HealthInteractorOutput {
}
