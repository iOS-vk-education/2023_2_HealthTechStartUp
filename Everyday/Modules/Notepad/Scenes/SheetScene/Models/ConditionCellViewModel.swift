//
//  ConditionCellViewModel.swift
//  Everyday
//
//  Created by Alexander on 13.04.2024.
//

import UIKit

struct ConditionCellViewModel {
    let title: String
    let conditionImage: UIImage?
    
    init(condition: Condition) {
        let titleLabelTitle = String(describing: condition).uppercased()
        let conditionImageName = condition.rawValue
        let conditionImage = UIImage(systemName: conditionImageName, withConfiguration: Configurations.large)
        
        self.title = titleLabelTitle
        self.conditionImage = conditionImage
    }
}

private extension ConditionCellViewModel {
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
