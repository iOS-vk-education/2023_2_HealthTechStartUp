//
//  ProfileAcknowledgementController.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//

import Foundation

class ProfileAcknowledgementController: ObservableObject {
    
    // MARK: - Properties
    
    @Published var selectedAge: Age = .small
    let ages: [Age] = [.small, .young, .adult, .old]
    
    @Published var selectedGender: Gender = .male
}
