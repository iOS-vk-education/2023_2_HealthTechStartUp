//
//  AuthorizationViewController.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import UIKit

final class AuthorizationViewController: UIViewController {
    // MARK: - private properties
    
    private let output: AuthorizationViewOutput
    private let signWithGoogleButton = UIButton(type: .custom)
    private let signWithVKButton     = UIButton(type: .custom)
    private let signWithAppleButton  = UIButton(type: .custom)
    private let signWithEmailButton  = UIButton(type: .custom)
    private let firstSeparator       = UIView()
    private let secondSeparator      = UIView()
    private let separatorLabel       = UILabel()
   
    // MARK: - lifecycle
    
    init(output: AuthorizationViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension AuthorizationViewController: AuthorizationViewInput {
}
