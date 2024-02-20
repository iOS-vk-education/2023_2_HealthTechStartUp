//
//  ProfileModel.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//
import UIKit
import FirebaseFirestore

struct ProfileAcknowledgementModel {
    let firstname: String?
    let lastname: String?
    let nickname: String?
    let email: String?
    let password: String?
    let profileImage: UIImage?
    let age: Int?
    let gender: String?
    let weight: Int?
    
    let schedule: [[DocumentReference]]
}
