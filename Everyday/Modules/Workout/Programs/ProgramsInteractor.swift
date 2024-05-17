//
//  ProgramsInteractor.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//
//

import Foundation

final class ProgramsInteractor {
    weak var output: ProgramsInteractorOutput?
    let catalogService: CatalogServiceDesription
    
    init(catalogService: CatalogServiceDesription) {
        self.catalogService = catalogService
    }
}

extension ProgramsInteractor: ProgramsInteractorInput {
    func loadWorkouts(for type: Target) {
        catalogService.loadTargetPrograms(for: type) { result in
            self.output?.didFetchWorkout(type: type, result)
        }
    }
}
