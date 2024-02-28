//
//  ResultsProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

protocol ResultsModuleInput {
    var moduleOutput: ResultsModuleOutput? { get }
}

protocol ResultsModuleOutput: AnyObject {
    func changeSet(with exercises: [Exercise])
}

protocol ResultsViewInput: AnyObject {
    func configure(with viewModel: ResultsViewModel)
    func reloadData()
    func getSelf() -> ResultsViewController
}

protocol ResultsViewOutput: AnyObject {
    func didLoadView()
    func numberOfRowsInSection(_ section: Int) -> Int
    func getExercise(at index: Int) -> Exercise
    func didTapCloseButton()
    func didTapRestButton()
    func didTapContinueButton()
}

protocol ResultsInteractorInput: AnyObject {
}

protocol ResultsInteractorOutput: AnyObject {
}

protocol ResultsRouterInput: AnyObject {
    func openTimer(with timerContext: TimerContext)
    func closeResults()
}
