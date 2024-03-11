//
//  TrainingRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class TrainingRouter {
    weak var viewController: TrainingViewController?
}

extension TrainingRouter: TrainingRouterInput {
    func openExercise(with exerciseContext: ExerciseContext) {
        guard let viewController = viewController else {
            return
        }
        
        let exerciseContainer = ExerciseContainer.assemble(with: exerciseContext)
        let exerciseViewController = exerciseContainer.viewController
        viewController.present(exerciseViewController, animated: true)
    }
    
    func showResults(with resultsContext: ResultsContext) {
        guard let viewController = viewController else {
            return
        }
        
        let resultsContainer = ResultsContainer.assemble(with: resultsContext)
        let resultsViewController = resultsContainer.viewController
        resultsViewController.modalPresentationStyle = .overFullScreen
        viewController.present(resultsViewController, animated: false)
    }
    
    func openExtra() {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let viewController = ExtraContainer.assemble(with: .init()).viewController
            viewController.modalPresentationStyle = .fullScreen
            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                window.rootViewController = viewController
            }, completion: nil)
        }
    }
    
    func openNotepad() {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let viewController = NotepadContainer.assemble(with: .init()).viewController
            viewController.modalPresentationStyle = .fullScreen
            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                window.rootViewController = viewController
            }, completion: nil)
        }
    }
}
