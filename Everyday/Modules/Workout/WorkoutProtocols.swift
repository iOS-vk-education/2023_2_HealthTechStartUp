//
//  WorkoutProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

protocol WorkoutModuleInput {
    var moduleOutput: WorkoutModuleOutput? { get }
}

protocol WorkoutModuleOutput: AnyObject {
}

protocol WorkoutViewInput: AnyObject {
}

protocol WorkoutViewOutput: AnyObject {
}

protocol WorkoutInteractorInput: AnyObject {
}

protocol WorkoutInteractorOutput: AnyObject {
}

protocol WorkoutRouterInput: AnyObject {
}
