//
//  ExtraInteractor.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class ExtraInteractor {
    weak var output: ExtraInteractorOutput?
    private let dayManager: DayServiceDescription

    init(dayManager: DayServiceDescription = DayService.shared) {
        self.dayManager = dayManager
    }
}

extension ExtraInteractor: ExtraInteractorInput {
    func saveProgress(_ progress: WorkoutProgress) {
        self.output?.didStartLoading()
        
        dayManager.postProgress(progress) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let workoutDays):
                self.output?.didEndLoading()
                self.output?.didPostData()
            case .failure:
                print("[DEBUG] failure")
                self.output?.didEndLoading()
            }
        }
    }
}
