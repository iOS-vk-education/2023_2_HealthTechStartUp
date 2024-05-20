//
//  NotepadInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import Foundation
import FirebaseAuth

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
            case .success(let workouts):
                self.output?.didEndLoading()
                self.output?.didLoadDay(with: workouts, true)
            case .failure:
                self.loadSchedule(date: date)
            }
        }
    }
    
    func loadDownloadedPrograms() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        CatalogService.shared.loadDownloadedWorkouts(for: user.uid) { result in
            self.output?.didExistDownloadPrograms(result)
        }
    }
    
    func loadSchedule(date: Date) {
        dayManager.getDaySchedule(on: date) { [weak self] result in
            guard let self else {
                return
            }
            self.output?.didEndLoading()

            switch result {
            case .success(let workouts):
                self.output?.didLoadDay(with: workouts, false)
            case .failure:
                self.output?.didLoadDay(with: [], false)
            }
        }
    }
}
