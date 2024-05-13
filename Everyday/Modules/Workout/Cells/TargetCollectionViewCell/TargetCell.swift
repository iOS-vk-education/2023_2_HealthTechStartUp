//
//  TargetCell.swift
//  workout
//
//  Created by Михаил on 03.04.2024.
//

import UIKit
import PinLayout

final class TargetCell: UICollectionViewCell {
    
    // MARK: - private properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Ivory")
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SpaceGray")
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
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
        
        imageView.pin.all()
        imageView.clipsToBounds = true
        
        label.pin
            .below(of: containerView)
            .marginTop(-2)
            .hCenter()
            .width(100%)
            .height(30)
        
        descriptionLabel.pin
            .below(of: label)
            .marginTop(-2)
            .hCenter()
            .width(100%)
            .height(44)
    }
    
    // MARK: - actions
    
    private func setUp() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(descriptionLabel)
    }
    
    func setImage(with image: UIImage) {
        imageView.image = image
    }
    
    // объединить эти методы
    func setText(_ text: String) {
        label.text = text
    }
    
    func setDescription(_ text: String) {
        descriptionLabel.text = text
    }
}
