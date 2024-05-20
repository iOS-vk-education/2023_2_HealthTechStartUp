//
//  NotepadProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import UIKit

protocol NotepadModuleInput {
    var moduleOutput: NotepadModuleOutput? { get }
}

protocol NotepadModuleOutput: AnyObject {
}

protocol NotepadViewInput: AnyObject {
    func configure(with viewModel: NotepadViewModel)
    func updateDateLabel(with text: String)
    func reloadData()
    func showLoadingView()
    func dismissLoadingView()
    func showEmptyStateView(with viewModel: NotepadEmptyStateViewModel)
    func hideEmptyStateView()
    func showAlert(with type: AlertType)
}

protocol NotepadViewOutput: AnyObject {
    func didLoadView()
    func didTapNewDate(_ date: Date)
    func getSelectedCell() -> (outerIndex: IndexPath, innerIndex: IndexPath)?
    func setSelectedCell(_ indexPaths: (outerIndex: IndexPath, innerIndex: IndexPath)?)
    func getSelectedCellOuterIndexPath() -> IndexPath?
    func getSelectedCellInnerIndexPath() -> IndexPath?
    func collectionNumberOfItems() -> Int
    func collectionItem(at index: Int) -> [Date]
    func headerViewState() -> NotepadSectionHeaderState
    func getWorkout(at index: Int) -> Workout
    func getAllExercises(at index: Int) -> [Exercise]
    func getExercise(at indexOfSection: Int, at indexOfRow: Int) -> Exercise
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func toggleCollapsed(at indexOfSection: Int) -> Bool
    func didTapHeaderView(number: Int)
    func didTapRightBarButtonItem()
}

protocol NotepadInteractorInput: AnyObject {
    func loadSchedule(date: Date)
    func loadResult(date: Date)
    func loadDownloadedPrograms()
}

protocol NotepadInteractorOutput: AnyObject {
    func didLoadDay(with workoutDays: [Workout], _ isResult: Bool)
    func didStartLoading()
    func didEndLoading()
    func didExistDownloadPrograms(_ result: Result<[Train], Error>)
}

protocol NotepadRouterInput: AnyObject {
    func openTraining(with context: TrainingContext)
    func openPrograms()
    func openPrograms(with trains: [Train], and type: String)
    func openEmptyPrograms(with type: String)
}
