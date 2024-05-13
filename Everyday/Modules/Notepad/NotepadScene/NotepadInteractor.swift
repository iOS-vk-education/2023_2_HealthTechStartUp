//
//  NotepadInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import Foundation

final class NotepadInteractor {
    weak var output: NotepadInteractorOutput?
    private let dayManager: DayServiceDescription

    init(dayManager: DayServiceDescription = DayService.shared) {
        self.dayManager = dayManager
    }
}

extension NotepadInteractor: NotepadInteractorInput {
    
    func loadResult(date: Date) {
        self.output?.didStartLoading()
        
        dayManager.getDayResults(on: date) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let workoutDays):
                self.output?.didEndLoading()
                self.output?.didLoadDay(with: workoutDays, true)
            case .failure:
                self.loadSchedule(date: date)
            }
        }
    }
    
    func loadSchedule(date: Date) {
        dayManager.getDaySchedule(on: date) { [weak self] result in
            guard let self else {
                return
            }
            self.output?.didEndLoading()

            switch result {
            case .success(let workoutDays):
                self.output?.didLoadDay(with: workoutDays, false)
            case .failure:
                self.output?.didLoadDay(with: [], false)
            }
        }
    }
}
