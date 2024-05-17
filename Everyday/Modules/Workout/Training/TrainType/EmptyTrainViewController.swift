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
    
    private let infoImage = UIImageView()
    private let infoLabel = UILabel()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.background
                
        setup()
        
        view.addSubviews(infoImage, infoLabel)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(didTapCloseButton)
            )
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
        let model = EmptyTrainViewModel()
        
        infoImage.contentMode = .scaleToFill
        infoImage.image = UIImage(named: model.imageTitle)
        
        infoLabel.attributedText = model.labelTitle
        infoLabel.numberOfLines = .zero
        infoLabel.textAlignment = .center
    }

    // MARK: - Layout
    
    private func layout() {
        infoImage.pin
            .hCenter()
            .vCenter(Constants.ImageView.top)
            .size(Constants.ImageView.size)
        
        infoLabel.pin
            .below(of: infoImage, aligned: .center)
            .size(Constants.Label.size)
            .sizeToFit(.height)
    }
    
    // MARK: - actions
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - extensions

private extension EmptyTrainViewController {
    struct Constants {
        static let background: UIColor = UIColor.background
        
        struct ImageView {
            static let size: CGSize = CGSizeMake(200, 200)
            static let top: CGFloat = -60
        }
        
        struct Label {
            static let size: CGSize = CGSizeMake(150, 70)
        }
    }
}
