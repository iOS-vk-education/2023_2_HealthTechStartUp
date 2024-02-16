//
//  AgeController.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

// MARK: - AgeViewController

class AgeViewController: ObservableObject {
    
    // MARK: - Properties
    
    @Published var selectedAge: Age = .small
    let ages: [Age] = [.small, .young, .adult, .old]
}
