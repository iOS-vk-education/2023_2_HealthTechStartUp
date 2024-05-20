//
//  PhotoLibraryViewModel.swift
//  Everyday
//
//  Created by Alexander on 20.05.2024.
//

import Foundation
import Firebase
import FirebaseStorage

class PhotoLibraryViewModel: ObservableObject {
    @Published var imageUrls: [URL] = []
    
    private let storage = Storage.storage()
    
    func fetchImageUrls() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }
        let storageRef = storage.reference().child("userPics").child(userUID)
        
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error listing images: \(error)")
                return
            }
            
            for item in result?.items ?? [] {
                item.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }
                    if let url = url {
                        DispatchQueue.main.async {
                            self.imageUrls.append(url)
                        }
                    }
                }
            }
        }
    }
}
