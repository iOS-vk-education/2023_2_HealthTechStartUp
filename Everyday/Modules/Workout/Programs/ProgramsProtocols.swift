//
//  ProgramsProtocols.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import UIKit

protocol ProgramsModuleInput {
    var moduleOutput: ProgramsModuleOutput? { get }
}

protocol ProgramsModuleOutput: AnyObject {
}

protocol ProgramsViewInput: AnyObject {
    func setup(with items: [ProgramsSectionItem])
    func showAlert(with type: AlertType)
}

protocol ProgramsViewOutput: AnyObject {
    func didLoadView()
    func didSelectTargetCell(type: Target)
    func didSelectTrainingCell(type: Training)
}

protocol ProgramsInteractorInput: AnyObject {
    func loadWorkouts(for type: Target)
    func loadWorkouts(for type: Training)
}

protocol ProgramsInteractorOutput: AnyObject {
    func didFetchWorkout(type: Target, _ result: Result<[Train], Error>)
    func didFetchWorkout(type: Training, _ result: Result<[Train], Error>)
}

protocol ProgramsRouterInput: AnyObject {
    func openCatalog(with trains: [Train], and type: String)
    func openEmptyCatalog()
}

protocol ProgramsViewControllerDelegate: AnyObject {
    func programsViewControllerRequestsPresentation(_ viewController: UIViewController)
}
