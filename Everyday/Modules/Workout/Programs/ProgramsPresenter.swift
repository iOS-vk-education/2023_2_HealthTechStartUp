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
    func didLoadView() {
        
        items.append(.trainingType(info: .init()))
        items.append(.targetType(info: .init()))
        items.append(.programLevelType(info: .init()))
        items.append(.otherType(info: .init()))
        
        view?.setup(with: items)
    }
}

extension ProgramsPresenter: ProgramsInteractorOutput {
}
