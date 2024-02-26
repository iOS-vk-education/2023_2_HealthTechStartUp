//
//  AnonymFieldGenerator.swift
//  Everyday
//
//  Created by Михаил on 26.02.2024.
//

import Foundation

struct NameGeneratorModel {
    let adjectives = ["NameGenerator_name_1".localized, "NameGenerator_name_2".localized,
                      "NameGenerator_name_3".localized, "NameGenerator_name_4".localized,
                      "NameGenerator_name_5".localized, "NameGenerator_name_6".localized,
                      "NameGenerator_name_7".localized, "NameGenerator_name_8".localized]
    
    let animals = ["NameGenerator_surname_1".localized, "NameGenerator_surname_2".localized,
                   "NameGenerator_surname_3".localized, "NameGenerator_surname_4".localized,
                   "NameGenerator_surname_5".localized, "NameGenerator_surname_6".localized,
                   "NameGenerator_surname_7".localized, "NameGenerator_surname_8".localized]
}

class NameGenerator {
    private let model = NameGeneratorModel()
    
    func generateName() -> String {
        return model.adjectives.randomElement() ?? ""
    }
    
    func generateSurname() -> String {
        return model.animals.randomElement() ?? ""
    }
}
