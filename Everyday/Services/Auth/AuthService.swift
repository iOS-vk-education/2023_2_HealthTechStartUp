//
//  AuthService.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import UIKit

protocol AuthServiceDescription {
    func authWithVKID(with presentingController: UIViewController)
    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func authWithFirebase(with userRequest: ProfileAcknowledgementModel)
}

final class AuthService: AuthServiceDescription {
    static let shared = AuthService()
    
    private let vkidAuthService: VKIDAuthServiceDescription
    private let googleAuthService: GoogleAuthServiceDescription
    private let firebaseAuthService: FirebaseAuthServiceDescription
    
    private init(vkidAuthService: VKIDAuthServiceDescription = VKIDAuthService.shared,
                 googleAuthService: GoogleAuthServiceDescription = GoogleAuthService.shared,
                 firebaseAuthService: FirebaseAuthServiceDescription = FirebaseAuthService.shared ) {
        self.vkidAuthService = vkidAuthService
        self.googleAuthService = googleAuthService
        self.firebaseAuthService = firebaseAuthService
    }
    
    func authWithVKID(with presentingController: UIViewController) {
        vkidAuthService.authWithVKID(with: presentingController)
    }
    
    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        googleAuthService.authWithGoogle(with: presentingController) { result in
            completion(result)
        }
    }
    
    func authWithFirebase(with userRequest: ProfileAcknowledgementModel) {
        firebaseAuthService.registerUser(with: userRequest) { success, error in
            if let error = error {
                print("Registration failed with error: \(error.localizedDescription)")
            } else {
                print("Registration successful: \(success)")
            }
        }
    }
}
