//
//  DeleteAccountRouter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class DeleteAccountRouter {
    weak var viewController: DeleteAccountViewController?
}

extension DeleteAccountRouter: DeleteAccountRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
