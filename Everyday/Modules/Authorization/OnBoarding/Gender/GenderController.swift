//
//  GenderController.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

import SwiftUI

// MARK: - GenderController

class GenderViewController: ObservableObject {
    
    // MARK: - Properties
    
    @Published var selectedGender: Gender = .male
}
