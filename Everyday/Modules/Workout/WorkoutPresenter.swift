//
//  WorkoutPresenter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class WorkoutPresenter {
    weak var view: WorkoutViewInput?
    weak var moduleOutput: WorkoutModuleOutput?
    
    private let router: WorkoutRouterInput
    private let interactor: WorkoutInteractorInput
    
    init(router: WorkoutRouterInput, interactor: WorkoutInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WorkoutPresenter: WorkoutModuleInput {
}

extension WorkoutPresenter: WorkoutViewOutput {
}

extension WorkoutPresenter: WorkoutInteractorOutput {
}
