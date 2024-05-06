//
//  String+Ext.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not be found in Localized file")
    }
    
    var isNumber: Bool {
        return self.allSatisfy { character in
            character.isNumber
        }
    }
}
