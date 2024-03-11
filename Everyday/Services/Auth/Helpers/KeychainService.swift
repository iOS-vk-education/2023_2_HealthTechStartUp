//
//  KeychainService.swift
//  Everyday
//
//  Created by Михаил on 28.02.2024.
//

import Security
import Foundation

class KeychainService {
    @discardableResult
    static func savePassword(_ password: String, for account: String) -> Bool {
        let passwordData = password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    static func loadPassword(for email: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var retrievedData: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &retrievedData)
        
        if status == errSecSuccess,
           let passwordData = retrievedData as? Data,
           let password = String(data: passwordData, encoding: .utf8) {
            return password
        } else {
            return nil
        }
    }
}
