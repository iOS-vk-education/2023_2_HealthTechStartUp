//
//  OtherCell.swift
//  workout
//
//  Created by Михаил on 06.04.2024.
//

import UIKit
import PinLayout

final class OtherCell: UICollectionViewCell {
    
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
    
    private let label = UILabel()
    
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
    }
    
    // MARK: - actions
    
    private func setUp() {
        setupLabel()
        
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(label)
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func setImage(with image: UIImage, indexPath: IndexPath) {
        imageView.image = image
        switch indexPath.item {
        case 0:
            label.text = "OtherCollectionViewCell_title_charge".localized
            
            label.pin
                .top()
                .left(16)
                .height(20)
                .width(100)
           
        case 1:
             label.text = "OtherCollectionViewCell_title_kegel".localized
             
             label.pin
                .top()
                .left(16)
                .height(40)
                .width(100)
            
        case 2:
            label.text = "OtherCollectionViewCell_title_eye".localized
            
            label.pin
                .top()
                .left(16)
                .height(40)
                .width(100)
        default: break
        }
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
    }
}
