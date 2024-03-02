//
//  NotepadPresenter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class NotepadPresenter {
    weak var view: NotepadViewInput?
    weak var moduleOutput: NotepadModuleOutput?
    
    private let router: NotepadRouterInput
    private let interactor: NotepadInteractorInput
    
    private var isResult: Bool = false
    private var workoutDays: [(workout: Workout, indexOfDay: Int)] = []
    private var isCollapsed = [
        true,
        true
    ]
    
    init(router: NotepadRouterInput, interactor: NotepadInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NotepadPresenter: NotepadModuleInput {
}

extension NotepadPresenter: NotepadViewOutput {
    func didLoadView() {
        interactor.loadResult(date: Date())
    }
    
    func headerViewState() -> NotepadSectionHeaderState {
        isResult ? .collapse : .open
    }
    
    func getWorkoutDay(_ number: Int) -> (workout: Workout, indexOfDay: Int) {
        (workoutDays[number])
    }
    
    func getWorkout(at indexOfWorkout: Int) -> Workout {
        workoutDays[indexOfWorkout].workout
    }
    
    func getExercises(at indexOfSection: Int) -> [Exercise] {
        workoutDays[indexOfSection].workout.days[workoutDays[indexOfSection].indexOfDay].sets.flatMap { $0.exercises }
    }
    
    func getExercise(at indexOfSection: Int, at indexOfRow: Int) -> Exercise {
        workoutDays[indexOfSection].workout.days[workoutDays[indexOfSection].indexOfDay].sets.flatMap { $0.exercises }[indexOfRow]
    }
    
    func numberOfSections() -> Int {
        workoutDays.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        isCollapsed[section] ? 0 : workoutDays[section].workout.days[workoutDays[section].indexOfDay].sets.flatMap { $0.exercises }.count
    }
    
    func toggleCollapsed(at indexOfSection: Int) -> Bool {
        isCollapsed[indexOfSection] = !isCollapsed[indexOfSection]
        return isCollapsed[indexOfSection]
    }
    
    func didTapHeaderView(number: Int) {
        let trainingContext = TrainingContext(workoutDay: workoutDays[number])
        router.openTraining(with: trainingContext)
    }
}

extension NotepadPresenter: NotepadInteractorOutput {
    func didLoadDay(with workoutDays: [(workout: Workout, indexOfDay: Int)], _ isResult: Bool) {
        self.workoutDays = workoutDays
        self.isResult = isResult
        
        let viewModel = NotepadViewModel(isResult: isResult)
        view?.configure(with: viewModel)
        view?.reloadData()
    }
    
    func didStartLoading() {
        view?.showLoadingView()
    }
    
    func didEndLoading() {
        view?.dismissLoadingView()
    }
}
