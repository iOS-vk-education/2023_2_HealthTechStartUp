//
//  WeightMeasurementViewModel.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit

struct WeightMeasurementViewModel {
    let value: NSAttributedString
    let minusImage: UIImage?
    let plusImage: UIImage?
    
    init(value: Double?) {
        var valueTextFieldTitle = "0,0"
        if let value {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let value = formatter.string(from: value as NSNumber) {
                valueTextFieldTitle = value
            }
        }
        let valueTextFieldAttributedString = NSAttributedString(string: valueTextFieldTitle, attributes: Styles.valueAttributes)
        let minusButtonImageName = "minus.circle.fill"
        let minusButtonImage = UIImage(systemName: minusButtonImageName, withConfiguration: Configurations.huge)
        let plusButtonImageName = "plus.circle.fill"
        let plusButtonImage = UIImage(systemName: plusButtonImageName, withConfiguration: Configurations.huge)
        
        self.value = valueTextFieldAttributedString
        self.minusImage = minusButtonImage
        self.plusImage = plusButtonImage
    }
}

private extension WeightMeasurementViewModel {
    struct Styles {
        static let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 72, weight: .bold),
            .foregroundColor: UIColor.UI.accent
        ]
    }
    
    struct Configurations {
        static let huge = UIImage.SymbolConfiguration(pointSize: 56)
    }
}
