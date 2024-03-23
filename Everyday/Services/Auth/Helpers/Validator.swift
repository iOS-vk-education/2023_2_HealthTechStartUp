//
//  Validator.swift
//  Everyday
//
//  Created by Михаил on 20.02.2024.
//

import Foundation

struct PasswordValidationError {
    static let length = "Validator_length".localized
    static let lowercase = "Validator_lovercase".localized
    static let uppercase = "Validator_uppercase".localized
    static let digit = "Validator_digit".localized
}

final class Validator {
    
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
        
    static func isValidUsername(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegEx = "[A-Za-z0-9]{4,24}"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }
    
    static func isValidName(for name: String) -> Bool {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nameRegEx = "[A-Za-zА-Яа-я]{2,32}"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }

    static func isValidSurname(for surname: String) -> Bool {
        let surname = surname.trimmingCharacters(in: .whitespacesAndNewlines)
        let surnameRegEx = "[A-Za-zА-Яа-я]{2,32}"
        let surnamePred = NSPredicate(format: "SELF MATCHES %@", surnameRegEx)
        return surnamePred.evaluate(with: surname)
    }
    
    static func validatePassword(for password: String) -> String {
        var errors = ""

        if password.count < 8 || password.count > 32 {
            errors += PasswordValidationError.length + "\n"
        }

        if !password.contains(where: { $0.isLowercase }) {
            errors += PasswordValidationError.lowercase + "\n"
        }

        if !password.contains(where: { $0.isUppercase }) {
            errors += PasswordValidationError.uppercase + "\n"
        }

        if !password.contains(where: { $0.isNumber }) {
            errors += PasswordValidationError.digit + "\n"
        }

        return errors
    }
}
