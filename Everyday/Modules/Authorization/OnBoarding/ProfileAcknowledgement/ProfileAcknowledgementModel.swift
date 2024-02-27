//
//  ProfileModel.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//
import UIKit
import FirebaseFirestore

class ProfileAcknowledgementModel {
    static let shared = ProfileAcknowledgementModel()

    var firstname: String?
    var lastname: String?
    var nickname: String?
    var email: String?
    var password: String?
    var profileImage: UIImage?
    var age: String?
    var gender: String?
    var weight: String?
    var schedule: [[DocumentReference]] = []
    
    init() {
    }
}
