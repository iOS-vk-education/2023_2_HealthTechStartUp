//
//  TargetCollectionViewCell.swift
//  workout
//
//  Created by Михаил on 03.04.2024.
//

import UIKit
import PinLayout

protocol TargetCollectionViewCellDelegate: AnyObject {
    func targetCollectionViewCellDidSelectItem(at indexPath: IndexPath)
}

final class TargetCollectionViewCell: UICollectionViewCell {
    
    // MARK: - private properties
    
    weak var delegate: TargetCollectionViewCellDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Ghost")
        collectionView.register(TargetCell.self, forCellWithReuseIdentifier: "TargetCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
        
        label.pin
            .left(15)
            .top()
            .width(300)
            .height(40)
        
        collectionView.pin
            .top(50)
            .left()
            .right()
            .bottom()
    }
    
    // MARK: - actions
    
    private func setUp() {
        setupLabel()
        contentView.addSubview(containerView)
        containerView.addSubview(label)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLabel() {
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Выбор по направлению"
        label.textColor = UIColor(named: "SpaceGray")
    }
    
    func configure(with model: TargetTypeViewModel) {        
    }
}

// MARK: - Collection View data source

extension TargetCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TargetCell", for: indexPath) as? TargetCell else {
            return .init()
        }
        
        let imageNames = ["recovery", "stamina", "flexibility", "muscleRelief", "coordination", "weightLoss", "muscleGain", "posture"]
        let imageName = imageNames[indexPath.item]
        
        if let image = UIImage(named: imageName) {
            cell.setImage(with: image)
        }
        
        let imageTitles = ["TargetCollectionViewCell_image_title_pic1".localized,
                          "TargetCollectionViewCell_image_title_pic2".localized,
                          "TargetCollectionViewCell_image_title_pic3".localized,
                          "TargetCollectionViewCell_image_title_pic4".localized,
                          "TargetCollectionViewCell_image_title_pic5".localized,
                          "TargetCollectionViewCell_image_title_pic6".localized,
                          "TargetCollectionViewCell_image_title_pic7".localized,
                          "TargetCollectionViewCell_image_title_pic8".localized]
        
        let imageTitle = imageTitles[indexPath.item]
        
        cell.setText(imageTitle)
        cell.setDescription("Item \(indexPath.item + 1)")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       8
    }
}

// MARK: - Collection View FlowLayout delegate

extension TargetCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 250, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: -60, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - Collection View delegate

extension TargetCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TargetCell else {
            return
        }
        delegate?.targetCollectionViewCellDidSelectItem(at: indexPath)
    }
}
