//
//  StorageService.swift
//  Everyday
//
//  Created by Михаил on 11.03.2024.
//

import UIKit
import FirebaseStorage

protocol StorageServiceDescription {
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String)
    func saveImage(image: UIImage, userId: String) async throws -> (path: String, name: String)
    func getData(userId: String, path: String) async throws -> Data
    func getImage(path: String) async throws -> UIImage?
    func deleteOldImage(userId: String, path: String) async throws
}
    
final class StorageService: StorageServiceDescription {
    
    static let shared = StorageService()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func saveImage(image: UIImage, userId: String) async throws -> (path: String, name: String) {
        guard let data = image.jpegData(compressionQuality: 0.002) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        
        return try await saveImage(data: data, userId: userId)
    }
    
    func getData(userId: String, path: String) async throws -> Data {
        try await userReference(userId: userId).child(path).data(maxSize: Constants.imageMaxSize)
    }
    
    func getImage(path: String) async throws -> UIImage? {
        let imageRef = storage.child(path)
        let data = try await imageRef.getDataAsync(maxSize: Constants.imageMaxSize)
        return UIImage(data: data)
    }

    func deleteOldImage(userId: String, path: String) async throws {
        let oldImageRef = storage.child(path)
        
        try await oldImageRef.delete()
    }
}

// MARK: - Constants

private extension StorageService {
    struct Constants {
        static let imageMaxSize: Int64 = 3 * 1024 * 1024
    }
}
