//
//  EmptyTrainViewController.swift
//  Everyday
//
//  Created by Михаил on 13.05.2024.
//

import UIKit
import PinLayout

final class EmptyTrainViewController: UIViewController {
    
    // MARK: - private properties
    
    private let infoImage = UIImage()
    private let infoLabel = UILabel()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Ghost")
                
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - Setup
    
    private func setup() {
    }
    
    // MARK: - Layout
    
    private func layout() {
    }
}

private extension EmptyTrainViewController {
    struct Constants {
    }
}
