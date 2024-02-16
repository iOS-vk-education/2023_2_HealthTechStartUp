//
//  ProfileModel.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//
import UIKit

struct ProfileAcknowledgementModel {
    var name: String = ""
    var surname: String = ""
    var nickname: String = ""
    var profileImage: UIImage?
    
    let age: Age
    
    let gender: Gender
    
    let weight: Int
}
