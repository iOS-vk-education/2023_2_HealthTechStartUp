//
//  ProfileAcknowledgementController.swift
//  welcome
//
//  Created by Михаил on 16.02.2024.
//

// import Foundation
//
// final class ProfileAcknowledgementController: ObservableObject {
//
//    enum whichAlert {
//        case nickname
//        case surname
//        case name
//        case none
//    }
//    
//    // MARK: - Properties
//    
//    @Published var selectedAge: Age = .small
//    let ages: [Age] = [.small, .young, .adult, .old]
//    
//    @Published var selectedGender: Gender = .male
//    
//    @Published var weight: String?
//    
//    @Published var name: String?
//    @Published var surname: String?
//    @Published var nickname: String?
//    
//    @Published var showingAlert: Bool = false
//    @Published var chooseAlert: whichAlert = .none
//    
//    init(ageDescription: String?,
//         genderDescription: String?,
//         weight: String?,
//         name: String?,
//         surname: String?,
//         nickname: String?) {
//            if let ageDesc = ageDescription, let age = Age.from(description: ageDesc) {
//                self.selectedAge = age
//            }
//            
//            if let genderDesc = genderDescription, let gender = Gender.from(description: genderDesc) {
//                self.selectedGender = gender
//            }
//            
//        self.weight = weight
//        
//        self.name = name
//        self.surname = surname
//        self.nickname = nickname
//        }
//    
//    func setAlert() {
//        switch chooseAlert {
//        case .nickname:
//            self.nickname = ""
//        case .name:
//            self.name = ""
//        case .surname:
//            self.surname = ""
//        default:
//            break
//        }
//        
//        showingAlert = true
//    }
// }
