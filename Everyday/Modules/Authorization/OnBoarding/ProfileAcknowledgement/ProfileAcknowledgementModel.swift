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
    private(set) var loadWeightMeasureUnit: String?

    private init() { }
    
    func update(firstname: String? = nil, lastname: String? = nil, nickname: String? = nil, email: String? = nil,
                password: String? = nil, profileImage: UIImage? = nil, age: String? = nil, gender: String? = nil,
                weight: String? = nil, profileImagePath: String? = nil,
                bodyWeightMeasureUnit: String? = nil, measurementsMeasureUnit: String? = nil,
                distanceMeasureUnit: String? = nil, loadWeightMeasureUnit: String? = nil) {
        self.firstname.updateValue(firstname)
        self.lastname.updateValue(lastname)
        self.nickname.updateValue(nickname)
        self.email.updateValue(email)
        self.password.updateValue(password)
        self.age.updateValue(age)
        self.gender.updateValue(gender)
        self.weight.updateValue(weight)
        self.profileImagePath.updateValue(profileImagePath)
        if let profileImage = profileImage { self.profileImage = profileImage }
        self.bodyWeightMeasureUnit.updateValue(bodyWeightMeasureUnit)
        self.measurementsMeasureUnit.updateValue(measurementsMeasureUnit)
        self.distanceMeasureUnit.updateValue(distanceMeasureUnit)
        self.loadWeightMeasureUnit.updateValue(loadWeightMeasureUnit)
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
