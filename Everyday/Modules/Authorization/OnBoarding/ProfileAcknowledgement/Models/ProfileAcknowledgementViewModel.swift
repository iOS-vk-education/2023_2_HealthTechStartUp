//
//  ProfileAcknowledgementViewModel.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//
    
import SwiftUI

final class ProfileAcknowledgementViewModel: ObservableObject {
    enum whichAlert {
        case nickname, surname, name, none
    }
    
    let ages: [Age] = [.small, .young, .adult, .old]
    
    @Published var showingAlert: Bool = false
    @Published var chooseAlert: whichAlert = .none
    
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage?
    
    var temp = UserProfile()
    
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
    
    let nicknameAlertTitle: String
    let nicknameAlertMessage: String
    let nameAlertTitle: String
    let nameAlertMessage: String
    let surnameAlertTitle: String
    let surnameAlertMessage: String
    let alertTitle: NSAttributedString
    
    struct GenderUI {
           let gender: Gender
           let imageName: String
           let localizedText: String
       }
    
    let gendersUI: [GenderUI] = [
            GenderUI(gender: .male, imageName: "male", localizedText: "Onboarding_user_gender_male".localized),
            GenderUI(gender: .female, imageName: "female", localizedText: "Onboarding_user_gender_female".localized),
            GenderUI(gender: .other, imageName: "other", localizedText: "Onboarding_user_gender_other".localized)
        ]
    
    init() {
        self.title = NSAttributedString(string: "Onboarding_ProfileAck_title".localized, attributes: Styles.titleAttributes)
        self.photoTitle = NSAttributedString(string: "Onboarding_user_choose_image_button_title".localized, attributes: Styles.buttonAttributes)
        self.starter = NSAttributedString(string: "Onboarding_start_button_title".localized, attributes: Styles.buttonAttributes)
        self.name = "Onboarding_user_name".localized
        self.surname = "Onboarding_user_surname".localized
        self.nickname = "Onboarding_user_nickname".localized
        self.placeholder = "Onboarding_Weight_description".localized
        self.ageConfirm = NSAttributedString(string: "Onboarding_ProfileAck_age_confirm".localized, attributes: Styles.buttonAttributes)
        self.genderConfirm = NSAttributedString(string: "Onboarding_ProfileAck_gender_confirm".localized, attributes: Styles.buttonAttributes)
        self.weightConfirm = NSAttributedString(string: "Onboarding_ProfileAck_weight_confirm".localized, attributes: Styles.buttonAttributes)
        self.alertTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.descriptionAttributes)
        self.nicknameAlertTitle = "Onboarding_invalid_username_title".localized
        self.nicknameAlertMessage = "Onboarding_invalid_username_message".localized
        self.nameAlertTitle = "Onboarding_invalid_name_title".localized
        self.nameAlertMessage = "Onboarding_invalid_name_message".localized
        self.surnameAlertTitle = "Onboarding_invalid_surname_title".localized
        self.surnameAlertMessage = "Onboarding_invalid_surname_message".localized
        
        inputImage = ProfileAcknowledgementModel.shared.profileImage
    }

    func loadImage() {
        if let inputImage = inputImage {
            temp.profileImage = inputImage
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
