//
//  ProgramsRouter.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import UIKit

final class ProgramsRouter {
    weak var viewController: ProgramsViewController?
}

extension ProgramsRouter: ProgramsRouterInput {
    func openCatalog(with trains: [Train], and type: String) {
        guard let viewController = viewController  else {
            return
        }
        let container = CatalogContainer.assemble(with: .init())
        container.input.setTrains(trains, type)
        
        let catalogViewController = container.viewController
        viewController.delegate?.programsViewControllerRequestsPresentation(catalogViewController)
    }
    
    func openEmptyCatalog() {
        guard let viewController = viewController  else {
            return
        }
        
        let emptyViewController = EmptyTrainViewController()
        viewController.delegate?.programsViewControllerRequestsPresentation(emptyViewController)
    }
}
