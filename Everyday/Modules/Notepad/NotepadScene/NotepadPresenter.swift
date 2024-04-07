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
    
    private var calendar: [[Date]] = []
    private var selectedCell: (outerIndex: IndexPath, innerIndex: IndexPath)?
    private var shouldDeselectCell: (outerIndex: IndexPath, innerIndex: IndexPath)?
    
    private var isResult: Bool = false
    private var workoutDays: [WorkoutDay] = []
    private var isCollapsed = [
        true,
        true
    ]
    
    init(router: NotepadRouterInput, interactor: NotepadInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NotepadPresenter: NotepadModuleInput {}

// MARK: - Helpers

private extension NotepadPresenter {
    func fetchWeeklyCalendar() -> [[Date]] {
        let calendar = Calendar.current
//        let formatter = DateFormatter()
//        formatter.dateFormat = Constants.DateFormatter.format
        guard
            let startDate = calendar.date(byAdding: .day, value: -14, to: Date()),  // date of first time entering app
            // fetch from UD using format: "2024/03/22"
            // let endDate = formatter.date(from: "2024/04/17")
            let endDate = calendar.date(byAdding: .day, value: 14, to: Date()),  // date of last training session
            let startWeek = calendar.dateInterval(of: .weekOfMonth, for: startDate),
            let endWeek = calendar.dateInterval(of: .weekOfMonth, for: endDate)
        else {
            return []
        }
        
        var start = startWeek.start
        let end = endWeek.start
        
        var weekArray: [[Date]] = []
        while start <= end {
            weekArray.append(fetchWeek(for: start))
            guard let nextDate = calendar.date(byAdding: .day, value: 7, to: start) else {
                return []
            }
            start = nextDate
        }
        
        return weekArray
    }
    
    func fetchWeek(for date: Date = Date()) -> [Date] {
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: date)
        
        guard let firstWeekDay = week?.start else {
            return []
        }
        
        var dateArray: [Date] = []
        (0...6).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                dateArray.append(weekDay)
            }
        }
        
        return dateArray
    }
}

// MARK: - ViewOutput

extension NotepadPresenter: NotepadViewOutput {
    func didLoadView() {
        calendar = fetchWeeklyCalendar()
        interactor.loadResult(date: Date())
    }
    
    func didTapNewDate(_ date: Date) {
        interactor.loadResult(date: date)
    }
    
    func getSelectedCell() -> (outerIndex: IndexPath, innerIndex: IndexPath)? {
        selectedCell
    }
    
    func getShouldDeselectCell() -> (outerIndex: IndexPath, innerIndex: IndexPath)? {
        shouldDeselectCell
    }
    
    func setSelectedCell(_ indexPaths: (outerIndex: IndexPath, innerIndex: IndexPath)? = nil) {
        selectedCell = indexPaths
    }
    
    func setShouldDeselectCell(_ indexPaths: (outerIndex: IndexPath, innerIndex: IndexPath)? = nil) {
        shouldDeselectCell = indexPaths
    }
    
    func getSelectedCellOuterIndexPath() -> IndexPath? {
        selectedCell?.outerIndex
    }
    
    func getShouldDeselectCellOuterIndexPath() -> IndexPath? {
        shouldDeselectCell?.outerIndex
    }
    
    func getSelectedCellInnerIndexPath() -> IndexPath? {
        selectedCell?.innerIndex
    }
    
    func collectionNumberOfItems() -> Int {
        calendar.count
    }
    
    func collectionItem(at index: Int) -> [Date] {
        calendar[index]
    }
    
    func headerViewState() -> NotepadSectionHeaderState {
        isResult ? .collapse : .open
    }
    
    func getWorkoutDay(_ number: Int) -> WorkoutDay {
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

// MARK: - InteractorOutput

extension NotepadPresenter: NotepadInteractorOutput {
    func didLoadDay(with workoutDays: [WorkoutDay], _ isResult: Bool) {
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

// MARK: - Constants

private extension NotepadPresenter {
    struct Constants {
        struct DateFormatter {
            static let format: String = "yyyy/MM/dd"
        }
    }
}
