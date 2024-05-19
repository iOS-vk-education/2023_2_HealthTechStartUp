//
//  AuthUserDefaults.swift
//  Everyday
//
//  Created by Yaz on 31.03.2024.
//

import Foundation

protocol AuthUserDefaultsDescription {
    func setWhichSign(signMethod: AuthModel.Sign)
}

final class AuthUserDefaultsService: AuthUserDefaultsDescription {
    public static let shared = AuthUserDefaultsService()
    
    private init() {}
    
    func setWhichSign(signMethod: AuthModel.Sign) {
        let defaults = UserDefaults.standard
        
        switch signMethod {
        case .google:
            defaults.set("google", forKey: "WhichSign")
        case .vk:
            defaults.set("vk", forKey: "WhichSign")
        case .common:
            defaults.set("email", forKey: "WhichSign")
//        case .apple:
//            defaults.set("vk", forKey: "WhichSign")
        default:
            break
        }
    }
}
