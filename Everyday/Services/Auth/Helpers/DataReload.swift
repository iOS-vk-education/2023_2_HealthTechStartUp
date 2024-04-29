//
//  DataReload.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//

import Foundation
import FirebaseAuth

protocol ReloaderDescription {
    func reloadAuthentication()
}

final class Reloader: ReloaderDescription {
    static let shared = Reloader()
    
    func reloadAuthentication() {
        guard Auth.auth().currentUser == nil else {
            return
        }
        
        loadAuthentication()
    }
    
    func loadAuthentication() {
        let authTypeArray: [String] = [
            KeychainService.loadString(for: "vkAuth") ?? "",
            KeychainService.loadString(for: "googleAuth") ?? "",
            KeychainService.loadString(for: "anonymAuth") ?? "",
            KeychainService.loadString(for: "emailAuth") ?? ""
        ]
        
        CoreDataService.shared.deleteAllItems()
        for authType in authTypeArray where !authType.isEmpty {
            CoreDataService.shared.createItem(authType: authType)
        }
    }
    
    func deleteAuthentication() {
        KeychainService.clearAll()
        
        loadAuthentication()
    }
    
    // delete authentication
}
