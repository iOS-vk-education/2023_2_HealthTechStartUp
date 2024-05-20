//
//  NotepadRouter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import UIKit

final class NotepadRouter {
    weak var viewController: NotepadViewController?
    
    private func present(with newViewController: UIViewController) {
        let navController = UINavigationController(rootViewController: newViewController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .coverVertical
        viewController?.present(navController, animated: true, completion: nil)
    }
}

extension NotepadRouter: NotepadRouterInput {
    func openEmptyPrograms(with type: String) {
        let emptyViewController = EmptyUserPrograms(labelTitle: type)
        present(with: emptyViewController)
    }
    
    func openPrograms(with trains: [Train], and type: String) {
        let container = CatalogContainer.assemble(with: .init())
        container.input.setTrains(trains, type)

        present(with: container.viewController)
    }
    
    func openTraining(with context: TrainingContext) {
        let trainingContainer = TrainingContainer.assemble(with: context)
        let trainingViewController = trainingContainer.viewController
        
        viewController?.navigationController?.pushViewController(trainingViewController, animated: true)
    }
    
    func openPrograms() {
    }
}
