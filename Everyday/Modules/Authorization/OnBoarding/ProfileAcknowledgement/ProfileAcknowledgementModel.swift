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

    private(set) var firstname: String?
    private(set) var lastname: String?
    private(set) var nickname: String?
    private(set) var email: String?
    private(set) var password: String?
    private(set) var age: String?
    private(set) var gender: String?
    private(set) var weight: String?
    private(set) var schedule: DayServiceSchedule?
    private(set) var history: [DayServiceHistoryElement]?
    private(set) var profileImagePath: String?
    private(set) var profileImage: UIImage?
    private(set) var bodyWeightMeasureUnit: String?
    private(set) var measurementsMeasureUnit: String?
    private(set) var distanceMeasureUnit: String?

    private init() { }

    func update(firstname: String? = nil, lastname: String? = nil, nickname: String? = nil, email: String? = nil,
                password: String? = nil, profileImage: UIImage? = nil, age: String? = nil, gender: String? = nil,
                weight: String? = nil, schedule: DayServiceSchedule? = nil,
                history: [DayServiceHistoryElement]? = nil, profileImagePath: String? = nil,
                bodyWeightMeasureUnit: String? = nil, measurementsMeasureUnit: String? = nil,
                loadWeightMeasureUnit: String? = nil, distanceMeasureUnit: String? = nil) {
        if let firstname = firstname { self.firstname = firstname }
        if let lastname = lastname { self.lastname = lastname }
        if let nickname = nickname { self.nickname = nickname }
        if let email = email { self.email = email }
        if let password = password { self.password = password }
        if let age = age { self.age = age }
        if let gender = gender { self.gender = gender }
        if let weight = weight { self.weight = weight }
        if let schedule = schedule { self.schedule = schedule }
        if let history = history { self.history = history }
        if let profileImagePath = profileImagePath { self.profileImagePath = profileImagePath }
        if let profileImage = profileImage { self.profileImage = profileImage }
        if let bodyWeightMeasureUnit = bodyWeightMeasureUnit { self.bodyWeightMeasureUnit = bodyWeightMeasureUnit}
        if let measurementsMeasureUnit = measurementsMeasureUnit { self.measurementsMeasureUnit = measurementsMeasureUnit}
        if let distanceMeasureUnit = distanceMeasureUnit { self.distanceMeasureUnit = distanceMeasureUnit}
    }
    
    enum Field {
        case firstname, lastname, nickname, email, password, profileImagePath, age, gender, weight, schedule, history, profileImage, bodyWeightMeasureUnit
    }

    func clear(fields: [Field]) {
        for field in fields {
            switch field {
            case .firstname:
                firstname = nil
            case .lastname:
                lastname = nil
            case .nickname:
                nickname = nil
            case .email:
                email = nil
            case .password:
                password = nil
            case .profileImagePath:
                profileImagePath = nil
            case .age:
                age = nil
            case .gender:
                gender = nil
            case .weight:
                weight = nil
            case .schedule:
                schedule = nil
            case .history:
                history = nil
            case .profileImage:
                profileImage = nil
            case .bodyWeightMeasureUnit:
                bodyWeightMeasureUnit = nil
            }
        }
    }
}
