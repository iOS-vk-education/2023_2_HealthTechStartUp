//
//  NotepadProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

protocol NotepadModuleInput {
    var moduleOutput: NotepadModuleOutput? { get }
}

protocol NotepadModuleOutput: AnyObject {
}

protocol NotepadViewInput: AnyObject {
    func configure(with viewModel: NotepadViewModel)
    func reloadData()
    func showLoadingView()
    func dismissLoadingView()
}

protocol NotepadViewOutput: AnyObject {
    func didLoadView()
    func headerViewState() -> NotepadSectionHeaderState
    func getWorkoutDay(_ number: Int) -> WorkoutDay
    func getWorkout(at indexOfWorkout: Int) -> Workout
    func getExercises(at indexOfSection: Int) -> [Exercise]
    func getExercise(at indexOfSection: Int, at indexOfRow: Int) -> Exercise
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func toggleCollapsed(at indexOfSection: Int) -> Bool
    func didTapHeaderView(number: Int)
}

protocol NotepadInteractorInput: AnyObject {
    func loadSchedule(date: Date)
    func loadResult(date: Date)
}

protocol NotepadInteractorOutput: AnyObject {
    func didLoadDay(with workoutDays: [WorkoutDay], _ isResult: Bool)
    func didStartLoading()
    func didEndLoading()
}

protocol NotepadRouterInput: AnyObject {
    func openTraining(with trainingContext: TrainingContext)
}
