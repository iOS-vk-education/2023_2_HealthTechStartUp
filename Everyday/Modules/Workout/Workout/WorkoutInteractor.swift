//
//  WorkoutInteractor.swift
//  workout
//
//  Created by Михаил on 21.03.2024.
//  
//

import Foundation

final class WorkoutInteractor {
    weak var output: WorkoutInteractorOutput?
}

extension WorkoutInteractor: WorkoutInteractorInput {
}
