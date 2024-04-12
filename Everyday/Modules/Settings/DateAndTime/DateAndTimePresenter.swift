//
//  DateAndTimePresenter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

final class DateAndTimePresenter {
    weak var view: DateAndTimeViewInput?
    weak var moduleOutput: DateAndTimeModuleOutput?
    
    private let router: DateAndTimeRouterInput
    private let interactor: DateAndTimeInteractorInput
    
    init(router: DateAndTimeRouterInput, interactor: DateAndTimeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DateAndTimePresenter: DateAndTimeModuleInput {
}

extension DateAndTimePresenter: DateAndTimeViewOutput {
    func didSwipe() {
        router.getBackToMainView()
    }
}

extension DateAndTimePresenter: DateAndTimeInteractorOutput {
}
