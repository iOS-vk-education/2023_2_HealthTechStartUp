//
//  WeightMeasurementViewModel.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit

struct WeightMeasurementViewModel {
    let value: NSAttributedString
    
    init(value: Double?) {
        var valueTextFieldTitle = ""
        if let value {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let value = formatter.string(from: value as NSNumber) {
                valueTextFieldTitle = value
            }
        }
        let valueTextFieldAttributedString = NSAttributedString(string: valueTextFieldTitle, attributes: Styles.valueAttributes)
        
        self.value = valueTextFieldAttributedString
    }
}

private extension WeightMeasurementViewModel {
    struct Styles {
        static let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 72, weight: .bold),
            .foregroundColor: UIColor.UI.accent
        ]
    }
}
