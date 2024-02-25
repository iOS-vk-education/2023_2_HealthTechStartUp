//
//  ProfileSetupModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import UIKit

struct UserProfile {
    var name: String = ProfileAcknowledgementModel.shared.firstname ?? ""
    var surname: String = ProfileAcknowledgementModel.shared.lastname ?? ""
    var nickname: String = ""
    var profileImage: UIImage?
}
