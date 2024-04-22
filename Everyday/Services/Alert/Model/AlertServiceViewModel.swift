//
//  AlertServiceViewModel.swift
//  Everyday
//
//  Created by Михаил on 22.04.2024.
//

import UIKit

enum AlertType {
    case invalidEmail
    case invalidPassword
    case invalidPasswordWithRegExp(description: String)
    
    case registrationMessage(description: String)
    case registered(description: String)
    
    case signInMessage(description: String)
    
    case logoutError(error: Error)
    
    case forgotPasswordMessage(description: String)
    
    case fetchingUserError(error: Error)
    case unknownFetchingUserError
    
    case ruSignWithGoogle
    case ruSignWithAppleID
    
    case signWithAppleID
}

struct AlertServiceViewModel {
    let labelTitle: NSAttributedString
    let labelDescription: NSAttributedString
    let buttonTitle: NSAttributedString
    
    init(alertType: AlertType) {
        switch alertType {
        // MARK: Validation
            
        case .invalidEmail:
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_email_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: "AlertManager_invalid_email_message".localized, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        case .invalidPassword:
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_password_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: "AlertManager_invalid_password_message".localized, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        case .invalidPasswordWithRegExp(let description):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_password_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: description, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        // MARK: - Registration
            
        case .registrationMessage(let description):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_registration_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: description, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        case .registered(let description):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_registration_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: description, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        // MARK: - Sign in
            
        case .signInMessage(let description):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_signin_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: description, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        // MARK: - Logout
            
        case .logoutError(let error):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_logout_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: error.localizedDescription, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        // MARK: - Forgot password

        case .forgotPasswordMessage(let description):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_password_reset_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: description, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        // MARK: - Fetching User
            
        case .fetchingUserError(error: let error):
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_fetching_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: error.localizedDescription, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        case .unknownFetchingUserError:
            self.labelTitle = NSAttributedString(string: "AlertManager_invalid_fetching_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: "", attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.buttonAttributes)
            
        // MARK: - Foreign Services
            
        case .ruSignWithGoogle:
            self.labelTitle = NSAttributedString(string: "AlertManager_ru_google_sign_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: "AlertManager_ru_sign_description".localized, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_ru_sign_button".localized, attributes: Styles.buttonAttributes)
           
        case .ruSignWithAppleID:
            self.labelTitle = NSAttributedString(string: "AlertManager_ru_apple_sign_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: "AlertManager_ru_sign_description".localized, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_ru_sign_button".localized, attributes: Styles.buttonAttributes)
            
        case .signWithAppleID:
            self.labelTitle = NSAttributedString(string: "AlertManager_apple_sign_title".localized, attributes: Styles.titleAttributes)
            self.labelDescription = NSAttributedString(string: "AlertManager_apple_sign_description".localized, attributes: Styles.descriptionAttributes)
            self.buttonTitle = NSAttributedString(string: "AlertManager_ru_sign_button".localized, attributes: Styles.buttonAttributes)
        }
    }
}

private extension AlertServiceViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 16)
        ]
    }
}
