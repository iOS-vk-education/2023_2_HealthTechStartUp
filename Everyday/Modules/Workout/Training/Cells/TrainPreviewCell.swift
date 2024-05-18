//
//  TrainPreviewCell.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import UIKit
import PinLayout

final class TrainPreviewCell: UICollectionViewCell {
    
    // MARK: - private properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        return view
    }()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let levelLabel = UILabel()
    
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
        
        imageView.pin
            .top()
            .height(150)
            .width(contentView.frame.width)
        
        levelLabel.pin
            .below(of: imageView)
            .marginTop(2)
            .left(10)
            .height(40)
            .width(contentView.frame.width)
        
        titleLabel.pin
            .below(of: levelLabel)
            .left(10)
            .height(60)
            .width(contentView.frame.width)
    }
    
    // MARK: - actions
    
    private func setUp() {
        setupImage()
        setupLabel()
        
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(levelLabel)
        containerView.addSubview(titleLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    func configure(with model: ExercisePreviewViewModel) {
        titleLabel.attributedText = model.title
        levelLabel.attributedText = model.level
        imageView.image = model.image
    }
    
    func getImage() -> UIImage {
        guard let image = imageView.image else {
            return UIImage()
        }
        
        return image
    }
    
    private func setupImage() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    private func setupLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.Text.primary
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        levelLabel.textColor = UIColor.Text.primary
        levelLabel.textAlignment = .left
    }
}
