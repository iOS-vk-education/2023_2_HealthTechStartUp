//
//  CatalogService.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import UIKit
import Firebase

protocol CatalogServiceDesription {
    func loadTargetPrograms(for target: Target, completion: @escaping (Result<[Train], Error>) -> Void)
    func loadTrainingPrograms(for training: Training, completion: @escaping (Result<[Train], Error>) -> Void)
    func loadOtherPrograms(for other: Other, completion: @escaping (Result<[Train], Error>) -> Void)
    func loadLevelPrograms(for level: Level, completion: @escaping (Result<[Train], Error>) -> Void)
}

final class CatalogService: CatalogServiceDesription {
    static let shared = CatalogService()
    
    private let targetService: TargetServiceDescription
    private let trainingService: TrainingTypeServiceDescription
    private let otherService: OtherServiceDescription
    private let levelService: LevelServiceDescription
    
    private init(targetService: TargetServiceDescription = TargetService.shared,
                 trainingService: TrainingTypeServiceDescription = TrainingTypeService.shared,
                 otherService: OtherServiceDescription = OtherService.shared,
                 levelService: LevelServiceDescription = LevelService.shared) {
        self.targetService = targetService
        self.trainingService = trainingService
        self.otherService = otherService
        self.levelService = levelService
    }
    
    func loadTargetPrograms(for target: Target, completion: @escaping (Result<[Train], Error>) -> Void) {
        targetService.loadWorkouts(for: target) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных"])))
            }
        }
    }
    
    func loadTrainingPrograms(for training: Training, completion: @escaping (Result<[Train], Error>) -> Void) {
        trainingService.loadWorkouts(for: training) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных"])))
            }
        }
    }
    
    func loadOtherPrograms(for other: Other, completion: @escaping (Result<[Train], Error>) -> Void) {
        otherService.loadWorkouts(for: other) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных"])))
            }
        }
    }
    
    func loadLevelPrograms(for level: Level, completion: @escaping (Result<[Train], any Error>) -> Void) {
        levelService.loadWorkouts(for: level) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных"])))
            }
        }
    }
}
