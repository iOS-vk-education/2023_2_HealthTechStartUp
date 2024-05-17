//
//  Optional+Extension.swift
//  Everyday
//
//  Created by Михаил on 13.05.2024.
//

import UIKit

extension Optional where Wrapped == String {
    mutating func updateValue(_ newValue: String?) {
        guard let newValue = newValue else {
            return
        }
        
        self = newValue
    }
}
