//
//  AuthUserDefaults.swift
//  Everyday
//
//  Created by Yaz on 31.03.2024.
//

import Foundation

func setWhichSign(signMethod: AuthModel.Sign) {
    let defaults = UserDefaults.standard
    
    switch signMethod {
    case .google:
        defaults.set("google", forKey: "WhichSign")
    case .vk:
        defaults.set("vk", forKey: "WhichSign")
    case .anonym:
        defaults.set("anonym", forKey: "WhichSign")
    case .email:
        defaults.set("email", forKey: "WhichSign")
    default:
        break
    }
}