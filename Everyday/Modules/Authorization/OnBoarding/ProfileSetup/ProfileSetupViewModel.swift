//
//  ProfileSetupViewModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

class ProfileSetupViewModel: ObservableObject {
    
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
        self.title = NSAttributedString(string: "onboard4_title".localized, attributes: Styles.titleAttributes)
        self.photoTitle = NSAttributedString(string: "onboard7_1".localized, attributes: Styles.buttonAttributes)
        self.next = NSAttributedString(string: "next".localized, attributes: Styles.buttonAttributes)
        self.name = "name".localized
        self.surname = "surname".localized
        self.nickname = "nickname".localized
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
