//
//  SheetViewModel.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit

struct SheetViewModel {
    let closeImage: UIImage?
    let saveImage: UIImage?
    
    init() {
        let closeButtonImageName = "xmark.circle.fill"
        let closeButtonImage = UIImage(systemName: closeButtonImageName, withConfiguration: Configurations.large)
        let saveButtonImageName = "checkmark.circle.fill"
        let saveButtonImage = UIImage(systemName: saveButtonImageName, withConfiguration: Configurations.large)
        
        self.closeImage = closeButtonImage
        self.saveImage = saveButtonImage
    }
}

private extension SheetViewModel {
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
