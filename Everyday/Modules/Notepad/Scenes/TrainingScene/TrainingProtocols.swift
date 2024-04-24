//
//  TrainingProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

protocol TrainingModuleInput {
    var moduleOutput: TrainingModuleOutput? { get }
}

protocol TrainingModuleOutput: AnyObject {
}

protocol TrainingViewInput: AnyObject {
    func configure(with viewModel: TrainingViewModel)
    func reloadData()
}

protocol TrainingViewOutput: AnyObject {
    func didLoadView()
    func numberOfRowsInSection(_ section: Int) -> Int
    func getExercise(at index: Int) -> NewExercise
    func getSwitchState(at index: Int) -> Bool
    func didSelectRowAt(index: Int)
    func didTapFinishButton()
}

protocol TrainingInteractorInput: AnyObject {
}

protocol TrainingInteractorOutput: AnyObject {
}

protocol TrainingRouterInput: AnyObject {
    func openExercise(with exerciseContext: ExerciseContext)
    func showResults(with resultsContext: ResultsContext)
    func openExtra()
    func openNotepad()
}
