//
//  WorkoutProtocols.swift
//  workout
//
//  Created by Михаил on 21.03.2024.
//  
//

import UIKit

protocol WorkoutModuleInput {
    var moduleOutput: WorkoutModuleOutput? { get }
}

protocol WorkoutModuleOutput: AnyObject {
}

protocol WorkoutViewInput: AnyObject {
    func setPrograms(_ view: UIViewController)
    func setWalkPrograms(_ view: UIViewController)
}

protocol WorkoutViewOutput: AnyObject {
    func didLoadView()
    func getPrograms()
    func getWalkPrograms()
}

protocol WorkoutInteractorInput: AnyObject {
}

protocol WorkoutInteractorOutput: AnyObject {
}

protocol WorkoutRouterInput: AnyObject {
    func getProgramsView() -> UIViewController
    func getWalkProgramsView() -> UIViewController
}
