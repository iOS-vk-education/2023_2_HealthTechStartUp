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
    func getImage(userId: String, completion: @escaping (UIImage?, Error?) -> Void) async throws
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
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        
        return try await saveImage(data: data, userId: userId)
    }
    
    func getData(userId: String, path: String) async throws -> Data {
        try await userReference(userId: userId).child(path).data(maxSize: Constants.imageMaxSize)
    }
    
    func getImage(userId: String, completion: @escaping (UIImage?, Error?) -> Void) async throws {
        let imagePath = "users/28SMwV0Hs8S5nIfILhIj8xUHPAt2/9E0D0103-AC8A-401C-AAC6-2D0DFA2B416F.jpeg"
        let imageRef = storage.child(imagePath)
        
        imageRef.getData(maxSize: Constants.imageMaxSize) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    completion(image, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
}

// MARK: - Constants

private extension StorageService {
    struct Constants {
        static let imageMaxSize: Int64 = 3 * 1024 * 1024
    }
}
