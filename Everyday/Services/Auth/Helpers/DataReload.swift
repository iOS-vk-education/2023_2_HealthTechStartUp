//
//  DataReload.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//

import Foundation
import FirebaseAuth

protocol ReloaderDescription {
    func setLogout()
    func getAuthType()
}

final class Reloader: ReloaderDescription {
    static let shared = Reloader()

    func setLogout() {
        CoreDataService.shared.deleteAllItems()
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
    }
    
   func getAuthType() {
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
}
