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
}

extension NotepadRouter: NotepadRouterInput {    
    func openTraining(with trainingContext: TrainingContext) {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let viewController = TrainingContainer.assemble(with: trainingContext).viewController
            viewController.modalPresentationStyle = .fullScreen
            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                window.rootViewController = viewController
            }, completion: nil)
        }
    }
}
