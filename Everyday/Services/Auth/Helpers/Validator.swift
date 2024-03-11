//
//  Validator.swift
//  Everyday
//
//  Created by Михаил on 20.02.2024.
//

import Foundation

struct PasswordValidationError {
    static let length = NSAttributedString(string: "Validator_length".localized)
    static let lowercase = NSAttributedString(string: "Validator_lovercase".localized)
    static let uppercase = NSAttributedString(string: "Validator_uppercase".localized)
    static let digit = NSAttributedString(string: "Validator_digit".localized)
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
    
    static func validatePassword(for password: String) -> NSMutableAttributedString {
        let errors = NSMutableAttributedString()

        if password.count < 8 || password.count > 32 {
            errors.append(PasswordValidationError.length)
            errors.append(NSAttributedString(string: "\n"))
        }

        if !password.contains(where: { $0.isLowercase }) {
            errors.append(PasswordValidationError.lowercase)
            errors.append(NSAttributedString(string: "\n"))
        }

        if !password.contains(where: { $0.isUppercase }) {
            errors.append(PasswordValidationError.uppercase)
            errors.append(NSAttributedString(string: "\n"))
        }

        if !password.contains(where: { $0.isNumber }) {
            errors.append(PasswordValidationError.digit)
            errors.append(NSAttributedString(string: "\n"))
        }
        return errors
    }
}
