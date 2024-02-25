//
//  GoogleAuthService.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

protocol GoogleAuthServiceDescription {
    func authWithGoogle(with presentingController: UIViewController)
}

final class GoogleAuthService: GoogleAuthServiceDescription {
    static let shared = GoogleAuthService()
    
    private init() {
    }
    
    func authWithGoogle(with presentingController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingController) { signInResult, error in
            guard signInResult != nil else {
                return
            }
            
            if let error = error {
                print("error")
            }
            
//            guard let clientID = FirebaseApp.app()?.options.clientID else {
//                return
//            }
//            
//            let config = GIDConfiguration(clientID: clientID)
//            GIDSignIn.sharedInstance.configuration = config

           guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else {
               print("token error")
               return
           }

           let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                          accessToken: user.accessToken.tokenString)
            
            AuthModel.shared.credential = credential
    
            ProfileAcknowledgementModel.shared.firstname = user.profile?.givenName
            ProfileAcknowledgementModel.shared.lastname = user.profile?.familyName
            ProfileAcknowledgementModel.shared.email = user.profile?.email
            // let profilePicUrl = user.profile?.imageURL(withDimension: 320)
        }
    }
}
