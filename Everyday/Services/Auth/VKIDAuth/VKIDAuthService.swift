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
    func authWithVKID(with presentingController: UIViewController)
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
    
    func authWithVKID(with presentingController: UIViewController) {
        vkid?.authorize(
            using: .uiViewController(presentingController)
        ) { result in
            do {
                let session = try result.get()
                print("Auth succeeded with token: \(session.accessToken) and user info: \(session.user)")
                
                let passwordGenerator = PasswordGenerator(length: 20)
                
                ProfileAcknowledgementModel.shared.firstname = session.user.firstName
                ProfileAcknowledgementModel.shared.lastname = session.user.lastName
                ProfileAcknowledgementModel.shared.email = session.user.email
                ProfileAcknowledgementModel.shared.password = passwordGenerator.generatePassword()
                // session.user.avatarURL
               
            } catch AuthError.cancelled {
                print("Auth cancelled by user")
            } catch {
                print("Auth failed with error: \(error)")
            }
        }
    }
}
