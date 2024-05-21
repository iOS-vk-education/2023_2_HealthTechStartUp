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
    private var selectedDate: Date = Date()
    
    private var isResult: Bool = false
    private var workouts: [Workout] = []
    private var isCollapsed: [Bool] = []
    
    init(router: NotepadRouterInput, interactor: NotepadInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NotepadPresenter: NotepadModuleInput {}

private extension NotepadPresenter {
    
    // MARK: - Init
    
    func initProperties() {
        let outerIndexPath = IndexPath(item: 2, section: 0)
        let innerIndex = CalendarService.shared.getWeekdayIndex(from: Date())
        let innerIndexPath = IndexPath(item: innerIndex, section: 0)
        selectedCell = (outerIndexPath, innerIndexPath)
    }
    
    // MARK: - Helpers
    
    func fetchWeeklyCalendar() -> [[Date]] {
        let calendar = Calendar.current
        guard
            let startDate = calendar.date(byAdding: .day, value: -14, to: Date()),
            let endDate = calendar.date(byAdding: .day, value: 14, to: Date()),
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
        initProperties()
        interactor.loadResult(date: Date())
    }
    
    func didTapNewDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormatter.format
        let dateLabelString = dateFormatter.string(from: date)
        selectedDate = date
        view?.updateDateLabel(with: dateLabelString)
        interactor.loadResult(date: date)
    }
    
    func getSelectedCell() -> (outerIndex: IndexPath, innerIndex: IndexPath)? {
        selectedCell
    }
    
    func setSelectedCell(_ indexPaths: (outerIndex: IndexPath, innerIndex: IndexPath)? = nil) {
        selectedCell = indexPaths
    }
    
    func getSelectedCellOuterIndexPath() -> IndexPath? {
        selectedCell?.outerIndex
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
        isResult ? .open : .collapse
    }
    
    func getWorkout(at index: Int) -> Workout {
        workouts[index]
    }
    
    func getAllExercises(at index: Int) -> [Exercise] {
        workouts[index].sets.flatMap { $0.exercises }
    }
    
    func getExercise(at indexOfSection: Int, at indexOfRow: Int) -> Exercise {
        getAllExercises(at: indexOfSection)[indexOfRow]
    }
    
    func numberOfSections() -> Int {
        workouts.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        isCollapsed[section] ? 0 : workouts[section].sets.flatMap({ $0.exercises }).count
    }
    
    func toggleCollapsed(at indexOfSection: Int) -> Bool {
        isCollapsed[indexOfSection] = !isCollapsed[indexOfSection]
        return isCollapsed[indexOfSection]
    }
    
    func didTapHeaderView(number: Int) {
        let trainingContext = TrainingContext(workout: workouts[number], date: selectedDate)
        router.openTraining(with: trainingContext)
    }
    
    func didTapRightBarButtonItem() {
        interactor.loadDownloadedPrograms()
    }
}

// MARK: - InteractorOutput

extension NotepadPresenter: NotepadInteractorOutput {
    func didExistDownloadPrograms(_ result: Result<[Train], any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let train):
                self.router.openPrograms(with: train, and: "NotepadPresenterLoadedPrograms".localized)
            case .failure(let error):
                if let nsError = error as NSError? {
                    if nsError.domain == "DataError" && nsError.code == -1 {
                        self.router.openEmptyPrograms(with: "NotepadPresenterLoadedPrograms".localized)
                    } else {
                        self.view?.showAlert(with: .networkMessage(error: error))
                    }
                } else {
                    self.view?.showAlert(with: .networkMessage(error: error))
                }
            }
        }
    }
    
    func didLoadDay(with workouts: [Workout], _ isResult: Bool) {
        self.workouts = workouts
        self.isResult = isResult
        self.isCollapsed = [Bool](repeating: true, count: workouts.count)
        
        view?.reloadData()
        
        if !workouts.isEmpty {
            view?.hideEmptyStateView()
            let viewModel = NotepadViewModel(isResult: isResult)
            view?.configure(with: viewModel)
        } else {
            let viewModel = NotepadEmptyStateViewModel()
            view?.showEmptyStateView(with: viewModel)
        }
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
            static let format: String = "EEEE, MMM d"
        }
    }
}
