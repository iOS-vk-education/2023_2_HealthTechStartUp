//
//  StoryCell.swift
//  workout
//
//  Created by Михаил on 26.03.2024.
//

import UIKit
import PinLayout

final class StoryCell: UICollectionViewCell {
    // MARK: - private properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SpaceGray")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Ivory")
        return view
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
        containerView.layer.cornerRadius = containerView.frame.width / 2
        
        imageView.pin.all()
        imageView.layer.cornerRadius = containerView.frame.width / 2
        imageView.clipsToBounds = true
        
        label.pin
            .below(of: containerView)
            .hCenter()
            .marginTop(4)
            .width(100%)
            .height(20)
    }
    
    // MARK: - actions
    
    private func setUp() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    func setText(_ text: String) {
        label.text = text
    }
    
    func setImage(with image: UIImage) {
        imageView.image = image
    }
}
