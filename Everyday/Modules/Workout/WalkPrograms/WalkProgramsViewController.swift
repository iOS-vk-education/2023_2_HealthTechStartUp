//
//  WalkProgramsViewController.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import UIKit
import PinLayout

final class WalkProgramsViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: WalkProgramsViewOutput
    
    private let walkImage = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - lifecycle

    init(output: WalkProgramsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.didLoadView()
        setupUI()
        
        view.addSubview(walkImage)
        view.addSubview(titleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - setup
    
    private func setupUI() {
        walkImage.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    // MARK: - layout
    
    private func layout() {
        walkImage.pin
            .hCenter()
            .top(100)
            .width(300)
            .height(300)
        
        titleLabel.pin
            .below(of: walkImage, aligned: .center)
            .marginTop(20)
            .width(250)
            .height(200)
    }
}

extension WalkProgramsViewController: WalkProgramsViewInput {
    func configure(with model: WalkProgramsViewModel) {
        walkImage.image = UIImage(named: model.image)
        titleLabel.attributedText = model.title
    }    
}
