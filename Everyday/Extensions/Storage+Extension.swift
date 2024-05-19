//
//  Storage+Extension.swift
//  Everyday
//
//  Created by Михаил on 18.05.2024.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    func getDataAsync(maxSize: Int64) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            self.getData(maxSize: maxSize) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
        }
    }
}
