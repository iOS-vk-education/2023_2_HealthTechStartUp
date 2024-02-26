//
//  PasswordGenerator.swift
//  Everyday
//
//  Created by Михаил on 26.02.2024.
//

import Foundation

class PasswordGenerator {
    private let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private let numbers = "0123456789"
    private var length: Int

    init(length: Int) {
        self.length = length
    }

    func generatePassword() -> String {
        let allowedChars = letters + numbers
        var randomString = ""

        for _ in 0..<length {
            let randomIndex = allowedChars.randomElement()!
            randomString += String(randomIndex)
        }

        return randomString
    }
}
