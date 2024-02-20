//
//  UIColor+Extension.swift
//  welcome
//
//  Created by Михаил on 07.02.2024.
//

import UIKit

extension UIColor {
    static let background: UIColor = {
        guard let color = UIColor(named: "Ghost") else {
            fatalError("Can't find color: Ghost")
        }
        
        return color
    }()
    
    struct UI {
        static let accent: UIColor = {
            guard let color = UIColor(named: "Pistachio") else {
                fatalError("Can't find color: Pistachio")
            }
            
            return color
        }()
        
        static let accentLight: UIColor = {
            guard let color = UIColor(named: "Ivory") else {
                fatalError("Can't find color: Ivory")
            }
            
            return color
        }()
    }
    
    struct Text {
        static let primary: UIColor = {
            guard let color = UIColor(named: "SpaceGray") else {
                fatalError("Can't find color: SpaceGray")
            }
                return color
            }()
            
            static let grayElement: UIColor = {
                guard let color = UIColor(named: "GrayElements") else {
                    fatalError("Can't find color: Snow")
                }
                return color
            }()
        }
}
