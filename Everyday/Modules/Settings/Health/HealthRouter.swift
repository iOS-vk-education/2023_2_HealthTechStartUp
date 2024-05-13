//
//  HealthRouter.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//  
//

import UIKit

final class HealthRouter {
    weak var viewController: HealthViewController?
}

extension HealthRouter: HealthRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
