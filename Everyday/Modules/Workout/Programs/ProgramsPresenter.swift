//
//  ProgramsPresenter.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import Foundation

final class ProgramsPresenter {
    weak var view: ProgramsViewInput?
    weak var moduleOutput: ProgramsModuleOutput?
    
    private let router: ProgramsRouterInput
    private let interactor: ProgramsInteractorInput
    
    private var items: [ProgramsSectionItem] = []
    
    init(router: ProgramsRouterInput, interactor: ProgramsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProgramsPresenter: ProgramsModuleInput {
}

extension ProgramsPresenter: ProgramsViewOutput {
    func didSelectTargetCell(type: Target) {
        interactor.loadWorkouts(for: type)
    }
    
    func didLoadView() {
        
        items.append(.trainingType(info: .init()))
        items.append(.targetType(info: .init()))
        items.append(.programLevelType(info: .init()))
        items.append(.otherType(info: .init()))
        
        view?.setup(with: items)
    }
}

extension ProgramsPresenter: ProgramsInteractorOutput {
    func didFetchWorkout(type: Target, _ result: Result<[Train], any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let trains):
                self.router.openCatalog(with: trains, and: type.description)
            case .failure(let error):
                if let nsError = error as NSError? {
                    if nsError.domain == "DataError" && nsError.code == -1 {
                        self.router.openEmptyCatalog()
                    } else {
                        self.view?.showAlert(with: .networkMessage(error: error))
                    }
                } else {
                    self.view?.showAlert(with: .networkMessage(error: error))
                }
            }
        }
    }
}
