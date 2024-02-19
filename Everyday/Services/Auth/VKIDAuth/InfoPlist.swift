//
//  InfoPlist.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import Foundation

enum InfoPlist {
    static var vkClientId: String? {
        Bundle.main.infoDictionary?["CLIENT_ID"] as? String
    }

    static var vkClientSecret: String? {
        Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String
    }
}
