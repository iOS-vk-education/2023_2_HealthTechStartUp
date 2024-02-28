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
    private let dayManager: DayManagerDescription

    init(dayManager: DayManagerDescription = DayManager.shared) {
        self.dayManager = dayManager
    }
}

extension NotepadInteractor: NotepadInteractorInput {
    
    func loadResult(date: Date) {
        dayManager.getDayResults(on: date) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let workoutDays):
                self.output?.didLoadDay(with: workoutDays, true)
            case .failure(let error):
                self.loadSchedule()
            }
        }
    }
    
    func loadSchedule() {
        dayManager.getDaySchedule { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let workoutDays):
                self.output?.didLoadDay(with: workoutDays, false)
            case .failure(let error):
                break
            }
        }
    }
}
