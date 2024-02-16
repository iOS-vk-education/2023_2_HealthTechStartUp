//
//  WorkoutInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class WorkoutInteractor {
    weak var output: WorkoutInteractorOutput?
}

extension WorkoutInteractor: WorkoutInteractorInput {
}
