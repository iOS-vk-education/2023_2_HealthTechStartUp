//
//  CatalogRouter.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import UIKit

final class CatalogRouter {
    weak var viewController: CatalogViewController?
}

extension CatalogRouter: CatalogRouterInput {
    func openCell(train: Train, image: UIImage) {
        guard let viewController = viewController else {
            return
        }
        
        let trainViewController = TrainViewController(model: train, image: image)
        
        let navController = UINavigationController(rootViewController: trainViewController)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .coverVertical
        viewController.present(navController, animated: true, completion: nil)
    }
}
