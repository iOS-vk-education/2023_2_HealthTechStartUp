//
//  ExerciseCell.swift
//  Everyday
//
//  Created by Михаил on 14.05.2024.
//

import UIKit
import PinLayout

final class ExerciseCell: UICollectionViewCell {
    
    // MARK: - private properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.1)
        return view
    }()
    
     let titleLabel = UILabel()
     let descriptionLabel = UILabel()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.pin.all()
        containerView.layer.cornerRadius = 8
        
        titleLabel.pin
            .top()
            .left(10)
            .height(20)
            .width(320)
        
        descriptionLabel.pin
            .below(of: titleLabel, aligned: .center)
            .left(10)
            .height(50)
            .width(320)
    }
    
    // MARK: - actions
    
    private func setUp() {
        setupLabel()
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    func setDescription(with text: String) {
        descriptionLabel.text = text
    }
    
    private func setupLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
    }
}
