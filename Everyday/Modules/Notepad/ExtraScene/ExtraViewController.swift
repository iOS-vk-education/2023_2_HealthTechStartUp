//
//  ExtraViewController.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ExtraViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: ExtraViewOutput
    
    // MARK: - Init

    init(output: ExtraViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

private extension ExtraViewController {
    
    // MARK: - Setup
    
    func setup() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - ExtraViewInput

extension ExtraViewController: ExtraViewInput {
}
