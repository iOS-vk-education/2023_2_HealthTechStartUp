//
//  CloseButton.swift
//  Everyday
//
//  Created by Михаил on 22.04.2024.
//

import UIKit

class CloseButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -10, dy: -10).contains(point)
    }
}
