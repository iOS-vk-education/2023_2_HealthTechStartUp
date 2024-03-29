//
//  AlertManager.swift
//  Everyday
//
//  Created by Михаил on 20.02.2024.
//

import UIKit

final class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "AlertManager_alert_title".localized, style: .default, handler: nil))
            vc.present(alert, animated: true)
    }
}

// MARK: - Show Validation Alerts

extension AlertManager {
    
    static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_email_title".localized, message: "AlertManager_invalid_email_message".localized)
    }
    
    static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_password_title".localized, message: "AlertManager_invalid_password_message".localized)
    }
    
    static func showInvalidPasswordAlert(on vc: UIViewController, message: String) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_password_title".localized, message: message)
    }
}

// MARK: - Registration Errors

extension AlertManager {
    
    static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_registration_title".localized, message: nil)
    }
    
    static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_registration_title".localized, message: "\(error.localizedDescription)")
    }
    
    static func showRegistrationErrorAlert(on vc: UIViewController, message: String) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_registration_title".localized, message: message)
    }
    
    static func showSignedUpAlert (on vc: UIViewController, message: String) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_registration_title".localized, message: message)
    }
}

// MARK: - Log In Errors

extension AlertManager {
    
    static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_signin_title".localized, message: nil)
    }
    
    static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_signin_title".localized, message: "\(error.localizedDescription)")
    }
    
    static func showSignInErrorAlert(on vc: UIViewController, message: String) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_signin_title".localized, message: message)
    }
}

// MARK: - Logout Errors

extension AlertManager {
    
    static func showLogoutError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_logout_title".localized, message: "\(error.localizedDescription)")
    }
}

// MARK: - Forgot Password

extension AlertManager {

    static func showPasswordResetSent(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "AlertManager_password_reset_title".localized, message: nil)
    }
    
    static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_password_reset_title".localized, message: "\(error.localizedDescription)")
    }
}

// MARK: - Fetching User Errors

extension AlertManager {
    
    static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_fetching_title".localized, message: "\(error.localizedDescription)")
    }
    
    static func showUnknownFetchingUserError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "AlertManager_invalid_fetching_title".localized, message: nil)
    }
}
