//
//  WorkoutPresenter.swift
//  workout
//
//  Created by Михаил on 21.03.2024.
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
    func getPrograms() {
        view?.setPrograms(router.getProgramsView())
    }
    
    func getWalkPrograms() {
        view?.setWalkPrograms(router.getWalkProgramsView())
    }
    
    func didLoadView() {
    }
}

extension WorkoutPresenter: WorkoutInteractorOutput {
}

extension WorkoutPresenter {
}
