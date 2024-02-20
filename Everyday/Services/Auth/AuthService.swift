//
//  AuthService.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import UIKit

protocol AuthServiceDescription {
    func authWithVKID(with presentingController: UIViewController)
    func authWithGoogle(with presentingController: UIViewController)
}

final class AuthService: AuthServiceDescription {
    static let shared = AuthService()
    
    private let vkidAuthService: VKIDAuthServiceDescription
    private let googleAuthService: GoogleAuthServiceDescription
    
    private init(vkidAuthService: VKIDAuthServiceDescription = VKIDAuthService.shared,
                 googleAuthService: GoogleAuthServiceDescription = GoogleAuthService.shared) { 
        self.vkidAuthService = vkidAuthService
        self.googleAuthService = googleAuthService
    }
    
    func authWithVKID(with presentingController: UIViewController) {
        vkidAuthService.authWithVKID(with: presentingController)
    }
    
    func authWithGoogle(with presentingController: UIViewController) {
        googleAuthService.authWithGoogle(with: presentingController)
    }
}
