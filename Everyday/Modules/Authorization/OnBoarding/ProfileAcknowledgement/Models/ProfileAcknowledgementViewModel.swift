//
//  ProfileAcknowledgementViewModel.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//

import SwiftUI

class ProfileAcknowledgementViewModel: ObservableObject {
    
    @Published var userProfile = UserProfile()
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage? {
        didSet {
            userProfile.profileImage = inputImage
        }
    }
    
    let title: NSAttributedString
    let photoTitle: NSAttributedString
    let starter: NSAttributedString
    let name: String
    let surname: String
    let nickname: String
    let placeholder: String
    let ageConfirm: NSAttributedString
    let genderConfirm: NSAttributedString
    let weightConfirm: NSAttributedString
    
    struct GenderUI {
           let gender: Gender
           let imageName: String
           let localizedText: String
       }
    
    let gendersUI: [GenderUI] = [
            GenderUI(gender: .male, imageName: "male", localizedText: "male".localized),
            GenderUI(gender: .female, imageName: "female", localizedText: "female".localized),
            GenderUI(gender: .other, imageName: "other", localizedText: "other".localized)
        ]
    
    init() {
        self.title = NSAttributedString(string: "ack".localized, attributes: Styles.titleAttributes)
        self.photoTitle = NSAttributedString(string: "onboard7_1".localized, attributes: Styles.buttonAttributes)
        self.starter = NSAttributedString(string: "start".localized, attributes: Styles.buttonAttributes)
        self.name = "name".localized
        self.surname = "surname".localized
        self.nickname = "nickname".localized
        self.placeholder = "onboard6_desc".localized
        self.ageConfirm = NSAttributedString(string: "age_confirm".localized, attributes: Styles.buttonAttributes)
        self.genderConfirm = NSAttributedString(string: "gender_confirm".localized, attributes: Styles.buttonAttributes)
        self.weightConfirm = NSAttributedString(string: "weight_confirm".localized, attributes: Styles.buttonAttributes)
    }

    func loadImage() {
        if let inputImage = inputImage {
            userProfile.profileImage = inputImage
        }
    }
    
    func ageText(for age: Age) -> String {
        switch age {
        case .small: return "17 - 24"
        case .young: return "25 - 34"
        case .adult: return "35 - 54"
        case .old: return "55+"
        }
    }
    
    func ageAttributedText(for age: Age) -> NSAttributedString {
        let text = ageText(for: age)
        return NSAttributedString(string: text, attributes: AgeViewModel.Styles.buttonAttributes)
    }
}

private extension ProfileAcknowledgementViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 26)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 24)
        ]
        
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
