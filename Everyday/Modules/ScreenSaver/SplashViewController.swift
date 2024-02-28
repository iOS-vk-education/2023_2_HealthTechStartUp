//
//  SplashViewController.swift
//  Everyday
//
//  Created by Михаил on 28.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    // swiftlint:disable private_outlet
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    
    var logoIsHidden: Bool = false
    var textImage: UIImage?
    
    static let logoImageBig: UIImage = UIImage(named: "logo")!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textImageView.image = textImage
        logoImageView.isHidden = logoIsHidden
    }
    // swiftlint:enable private_outlet
}
