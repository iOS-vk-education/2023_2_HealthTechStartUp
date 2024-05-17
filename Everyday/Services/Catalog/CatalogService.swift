//
//  CatalogService.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import UIKit

protocol CatalogServiceDesription {
    func loadTargetPrograms(for target: Target, completion: @escaping (Result<[Train], Error>) -> Void)
}

final class CatalogService: CatalogServiceDesription {
    static let shared = CatalogService()
    
    private let targetService: TargetServiceDescription
    
    private init(targetService: TargetServiceDescription = TargetService.shared) {
        self.targetService = targetService
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
}
