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
    func checkAuthentication() -> Bool
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
    
   func checkAuthentication() -> Bool {
        let coreDataService = CoreDataService.shared
        
        if Auth.auth().currentUser != nil {
            return true
        }
       
        guard let authTypes = coreDataService.getAllItems() else {
            return false
        }
        
        guard !authTypes.isEmpty else {
            return false
        }
        
        if !UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
            return false
        }
        
        return true
    }
}
