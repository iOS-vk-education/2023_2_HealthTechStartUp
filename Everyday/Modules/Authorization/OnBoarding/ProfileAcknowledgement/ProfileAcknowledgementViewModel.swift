//
//  ProfileAcknowledgementViewModel.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//
    
import SwiftUI

final class ProfileAcknowledgementViewModel: ObservableObject {
    let ages: [Age] = [.small, .young, .adult, .old]
    
    @Published var alertType: AlertType?
    @Published var showingAlert: Bool = false
    
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage?
        
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
    
    var storageService: StorageServiceDescription = StorageService.shared
    
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
    }

    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        ProfileAcknowledgementModel.shared.update(profileImage: inputImage)
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
