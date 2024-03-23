//
//  ProfileSetupViewModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

final class ProfileSetupViewModel: ObservableObject {
    
    enum whichAlert {
        case nickname
        case surname
        case name
        case none
    }
        
    @Published var userProfile = UserProfile()
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage? {
        didSet {
            userProfile.profileImage = inputImage
        }
    }
    @Published var showingAlert = false
    @Published var chooseAlert: whichAlert = .none
    
    let title: NSAttributedString
    let photoTitle: NSAttributedString
    let next: NSAttributedString
    let name: String
    let surname: String
    let nickname: String
    let image: String
    
    let nicknameAlertTitle: String
    let nicknameAlertMessage: String
    let nameAlertTitle: String
    let nameAlertMessage: String
    let surnameAlertTitle: String
    let surnameAlertMessage: String
    let alertTitle: NSAttributedString
    
    init() {
        self.title = NSAttributedString(string: "Onboarding_ProfileSetup_title".localized, attributes: Styles.titleAttributes)
        self.photoTitle = NSAttributedString(string: "Onboarding_user_choose_image_button_title".localized, attributes: Styles.buttonAttributes)
        self.next = NSAttributedString(string: "Onboarding_next_button_title".localized, attributes: Styles.buttonAttributes)
        self.name = "Onboarding_user_name".localized
        self.surname = "Onboarding_user_surname".localized
        self.nickname = "Onboarding_user_nickname".localized
        self.nicknameAlertTitle = "Onboarding_invalid_username_title".localized
        self.nicknameAlertMessage = "Onboarding_invalid_username_message".localized
        self.nameAlertTitle = "Onboarding_invalid_name_title".localized
        self.nameAlertMessage = "Onboarding_invalid_name_message".localized
        self.surnameAlertTitle = "Onboarding_invalid_surname_title".localized
        self.surnameAlertMessage = "Onboarding_invalid_surname_message".localized
        self.alertTitle = NSAttributedString(string: "AlertManager_alert_title".localized, attributes: Styles.descriptionAttributes)
        self.image = "anonymous"
    }

    func loadImage() {
        if let inputImage = inputImage {
            userProfile.profileImage = inputImage
        }
    }
    
    func setAlert() {
        switch chooseAlert {
        case .nickname:
            self.userProfile.nickname = ""
        case .name:
            self.userProfile.name = ""
        case .surname:
            self.userProfile.surname = ""
        default:
            break
        }
        
        showingAlert = true
    }
}

private extension ProfileSetupViewModel {
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
