//
//  ResultsPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class ResultsPresenter {
    weak var view: ResultsViewInput?
    weak var moduleOutput: ResultsModuleOutput?
    
    private let router: ResultsRouterInput
    private let interactor: ResultsInteractorInput
    
    private var exercises: [Exercise]
    
    init(router: ResultsRouterInput, interactor: ResultsInteractorInput, exercises: [Exercise]) {
        self.router = router
        self.interactor = interactor
        self.exercises = exercises
    }
}

extension ResultsPresenter: ResultsModuleInput {
}

extension ResultsPresenter: ResultsViewOutput {
    func didLoadView() {
        let viewModel = ResultsViewModel()
        view?.configure(with: viewModel)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        exercises.count
    }
    
    func getExercise(at index: Int) -> Exercise {
        exercises[index]
    }
    
    func didTapCloseButton() {
        router.dismissResults()
    }
    
    func didTapRestButton() {
        let timerModel: TimerModel = .init(seconds: Constants.defaultTimerTime)
        let sheetType: SheetType = .timer(model: timerModel)
        let sheetConext = SheetContext(type: sheetType)
        router.showView(with: sheetConext)
    }
    
    func didTapContinueButton() {
        moduleOutput?.changeSet(with: exercises)
        router.dismissResults()
    }
}

extension ResultsPresenter: ResultsInteractorOutput {
}

private extension ResultsPresenter {
    struct Constants {
        static let defaultTimerTime: Int = 5
    }
}
