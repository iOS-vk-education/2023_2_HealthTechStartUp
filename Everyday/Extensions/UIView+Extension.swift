//
//  UIView+Extension.swift
//  welcome
//
//  Created by Михаил on 07.02.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
