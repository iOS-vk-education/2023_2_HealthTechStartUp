//
//  TrainingTypeCell.swift
//  workout
//
//  Created by Михаил on 24.03.2024.
//

import UIKit
import PinLayout

protocol TrainingTypeCollectionViewCellDelegate: AnyObject {
    func trainingTypeCollectionViewCellDidSelectItem(type: Training)
}

final class TrainingTypeCollectionViewCell: UICollectionViewCell {
    // MARK: - private properties
    
    weak var delegate: TrainingTypeCollectionViewCellDelegate?
    
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
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var imageNames: [String] = []
    private var imageDescription: [String] = []
        
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
        collectionView.pin.all()
    }
    
    // MARK: - actions
    
    private func setUp() {
        contentView.addSubview(containerView)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure(with model: TrainingTypeViewModel) {
    }
}

// MARK: - Collection View data source

extension TrainingTypeCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell else {
            return .init()
        }
        
        let imageNames = ["FullBody", "Legs", "Hands", "Chest", "Shoulders", "Press", "Back"]
        let imageName = imageNames[indexPath.item]
            if let image = UIImage(named: imageName) {
                cell.setImage(with: image)
            }

        let imageDescriptions = ["TrainingCollectionViewCell_description_pic1".localized,
             "TrainingCollectionViewCell_description_pic2".localized,
             "TrainingCollectionViewCell_description_pic3".localized,
             "TrainingCollectionViewCell_description_pic4".localized,
             "TrainingtCollectionViewCell_description_pic5".localized,
             "TrainingCollectionViewCell_description_pic6".localized,
             "TrainingCollectionViewCell_description_pic7".localized]
        cell.setText("\(imageDescriptions[indexPath.row])")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       7
    }
}

// MARK: - Collection View FlowLayout delegate

extension TrainingTypeCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 90, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: -20, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - Collection View delegate

extension TrainingTypeCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? StoryCell else {
            return
        }

        UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    cell.transform = CGAffineTransform.identity
                }
            }
        )
        
        switch indexPath.item {
        case 0:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .fullBody)
        case 1:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .legs)
        case 2:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .hands)
        case 3:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .chest)
        case 4:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .shoulders)
        case 5:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .press)
        case 6:
            delegate?.trainingTypeCollectionViewCellDidSelectItem(type: .back)
        default:
            return
        }
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? StoryCell {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? StoryCell {
                cell.transform = CGAffineTransform.identity
            }
        }
    }
}
