//
//  LevelCell.swift
//  workout
//
//  Created by Михаил on 01.04.2024.
//

import UIKit
import PinLayout

final class LevelCell: UICollectionViewCell {
    
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
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupLabel() {
        if Locale.current.language.languageCode?.identifier == "ru" {
            label.font = UIFont.boldSystemFont(ofSize: 20)
        } else {
            label.font = UIFont.boldSystemFont(ofSize: 27)
        }
        label.textColor = .black
        label.textAlignment = .center
    }
    
    func setImage(with image: UIImage, indexPath: IndexPath) {
        imageView.image = image
        switch indexPath.item {
        case 0:
            label.text = "ProgramLevelsCollectionViewCell_title_easy".localized
            label.pin
                .top(76)
                .left(-28)
                .height(35)
                .width(150)
        case 1:
            label.text = "ProgramLevelsCollectionViewCell_title_medium".localized
            label.pin
                .top()
                .left(16)
                .height(35)
                .width(150)
        case 2:
            label.text = "ProgramLevelsCollectionViewCell_title_pro".localized
            label.pin
                .top(20)
                .left(-10)
                .height(35)
                .width(150)
            
        default: break
        }
    }    
}
