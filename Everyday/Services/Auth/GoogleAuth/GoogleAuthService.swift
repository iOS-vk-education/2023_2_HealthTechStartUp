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
    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
}

final class GoogleAuthService: GoogleAuthServiceDescription {

    static let shared = GoogleAuthService()
    
    var credential: AuthCredential?
    
    private init() {
    }
    
    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingController) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else {
                let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user information"])
                completion(.failure(error))
                return
            }

            GoogleAuthService.shared.credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            if let profilePicUrl = user.profile?.imageURL(withDimension: Constants.imageDimension) {
                self.downloadProfileImage(from: profilePicUrl) { image in
                    guard let image = image else {
                        completion(.failure(NSError(domain: "DownloadError", code: -2, 
                                                    userInfo: [NSLocalizedDescriptionKey: "Unable to download profile image"])))
                        return
                    }
                    ProfileAcknowledgementModel.shared.update(firstname: user.profile?.givenName,
                                                              lastname: user.profile?.familyName,
                                                              email: user.profile?.email,
                                                              profileImage: image)
                }
                completion(.success(()))
            }
        }
    }
    
    func loginWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingController) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else {
                let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user information"])
                completion(.failure(error))
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
        }
    }
    
    func downloadProfileImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}

// MARK: - Constants
private extension GoogleAuthService {
    struct Constants {
        static let imageDimension: UInt = 320
    }
}
