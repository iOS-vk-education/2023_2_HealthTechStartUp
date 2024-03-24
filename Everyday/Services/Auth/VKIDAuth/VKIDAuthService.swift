//
//  VKIDAuthService.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import UIKit
import VKID

protocol VKIDAuthServiceDescription {
    var vkid: VKID? { get }
    func authWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
}

final class VKIDAuthService: VKIDAuthServiceDescription {
    static let shared = VKIDAuthService()
    
    var vkid: VKID?
    
    private init() {
        guard
            let clientId = InfoPlist.vkClientId, !clientId.isEmpty,
            let clientSecret = InfoPlist.vkClientSecret, !clientSecret.isEmpty
        else {
            preconditionFailure("Info.plist does not contain correct values for CLIENT_ID and CLIENT_SECRET keys")
        }
        
        do {
            let vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: clientId,
                        clientSecret: clientSecret
                    )
                )
            )
            self.vkid = vkid
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
    }
    
    func authWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        vkid?.authorize(
            using: .uiViewController(presentingController)
        ) { result in
            do {
                let session = try result.get()
                let passwordGenerator = PasswordGenerator(length: 20)
                let password = passwordGenerator.generatePassword()
                guard let email = session.user.email  else {
                    let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user information"])
                    completion(.failure(error))
                    return
                }
                
                KeychainService.savePassword(password, for: email)
                
                if let avatarURL = session.user.avatarURL {
                    self.downloadProfileImage(from: avatarURL) { image in
                        guard let image = image else {
                            completion(.failure(NSError(domain: "DownloadError", code: -2,
                                                        userInfo: [NSLocalizedDescriptionKey: "Unable to download profile image"])))
                            return
                        }
                        
                        ProfileAcknowledgementModel.shared.update(firstname: session.user.firstName,
                                                                  lastname: session.user.lastName,
                                                                  email: email,
                                                                  password: password,
                                                                  profileImage: image)
                    }
                    
                    completion(.success(()))
                }
            } catch AuthError.cancelled {
                return                
            } catch {
                let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user information"])
                completion(.failure(error))
                return
            }
        }
    }
    
    func loginWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        vkid?.authorize(
            using: .uiViewController(presentingController)
        ) { result in
            do {
                let session = try result.get()
               
                guard let email = session.user.email, let password = KeychainService.loadPassword(for: email)  else {
                    let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user information"])
                    completion(.failure(error))
                    return
                }
                
                let model = SignInModel(email: email, password: password)
                FirebaseAuthService.shared.login(with: model) { _, error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } catch AuthError.cancelled {
                print("Auth cancelled by user")
                return
            } catch {
                let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user information"])
                completion(.failure(error))
                return
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
