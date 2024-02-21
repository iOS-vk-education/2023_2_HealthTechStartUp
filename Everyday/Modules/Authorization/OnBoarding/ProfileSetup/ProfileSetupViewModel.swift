//
//  ProfileSetupViewModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

final class ProfileSetupViewModel: ObservableObject {
    
    @Published var userProfile = UserProfile()
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage? {
        didSet {
            userProfile.profileImage = inputImage
        }
    }
    
    let title: NSAttributedString
    let photoTitle: NSAttributedString
    let next: NSAttributedString
    let name: String
    let surname: String
    let nickname: String
    
    init() {
        self.title = NSAttributedString(string: "Onboarding_ProfileSetup_title".localized, attributes: Styles.titleAttributes)
        self.photoTitle = NSAttributedString(string: "Onboarding_user_choose_image_button_title".localized, attributes: Styles.buttonAttributes)
        self.next = NSAttributedString(string: "Onboarding_next_button_title".localized, attributes: Styles.buttonAttributes)
        self.name = "Onboarding_user_name".localized
        self.surname = "Onboarding_user_surname".localized
        self.nickname = "Onboarding_user_nickname".localized
    }

    func loadImage() {
        if let inputImage = inputImage {
            userProfile.profileImage = inputImage
        }
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
