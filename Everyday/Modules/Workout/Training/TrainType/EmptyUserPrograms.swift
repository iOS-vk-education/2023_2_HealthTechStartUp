//
//  EmptyUserPrograms.swift
//  Everyday
//
//  Created by Михаил on 20.05.2024.
//

import UIKit
import PinLayout

final class EmptyUserPrograms: UIViewController {
    
    // MARK: - private properties
    
    private let infoLabel = UILabel()
    private let labelTitle: String
    private let descriptionLabel = UILabel()
    
    // MARK: - lifecycle
    
    init(labelTitle: String) {
        self.labelTitle = labelTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.background
                
        setup()
        
        view.addSubviews(infoLabel, descriptionLabel)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(didTapCloseButton)
            )
        
        navigationItem.leftBarButtonItem?.tintColor = Constants.textColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewModel = EmptyUserProgramsViewModel(title: labelTitle)
        
        infoLabel.attributedText = viewModel.title
        descriptionLabel.attributedText = viewModel.description
        
        for label in [infoLabel, descriptionLabel] {
            label.numberOfLines = .zero
            label.textAlignment = .center
        }
    }

    // MARK: - Layout
    
    private func layout() {
        infoLabel.pin
            .top(view.pin.safeArea.top)
            .hCenter()
            .size(Constants.Label.size)
            .sizeToFit(.height)
        
        descriptionLabel.pin
            .below(of: infoLabel, aligned: .center)
            .size(Constants.Label.size)
            .sizeToFit(.height)
    }
    
    // MARK: - actions
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - extensions

private extension EmptyUserPrograms {
    struct Constants {
        static let background: UIColor = UIColor.background
        static let textColor: UIColor = UIColor.Text.primary
        
        struct Label {
            static let size: CGSize = CGSizeMake(150, 70)
        }
    }
}
