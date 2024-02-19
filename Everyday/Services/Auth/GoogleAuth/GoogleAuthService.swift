//
//  GoogleAuthService.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import UIKit
import GoogleSignIn

protocol GoogleAuthServiceDescription {
    func authWithGoogle(with presentingController: UIViewController)
}

final class GoogleAuthService: GoogleAuthServiceDescription {
    static let shared = GoogleAuthService()
    
    private init() {
    }
    
    func authWithGoogle(with presentingController: UIViewController) {
        // swiftlint:disable unused_closure_parameter
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingController) { signInResult, error in
            guard signInResult != nil else {
                
                return
            }

            // If sign in succeeded, display the app's main content View.
        }
    }
}
// swiftlint:enable unused_closure_parameter
