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
    @IBOutlet weak var quoteLabel: UILabel!
    
    var logoIsHidden: Bool = false
    var text: NSAttributedString?
    
    static let logoImageBig: UIImage = UIImage(named: "logo")!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        quoteLabel.numberOfLines = 0
        quoteLabel.textAlignment = .center
        quoteLabel.font = UIFont.boldSystemFont(ofSize: 26)
        quoteLabel.lineBreakMode = .byWordWrapping
        quoteLabel.attributedText = text
                
        logoImageView.isHidden = logoIsHidden
    }
    // swiftlint:enable private_outlet
}
