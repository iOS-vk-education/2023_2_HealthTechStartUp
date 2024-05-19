//
//  OtherCollectionViewCell.swift
//  workout
//
//  Created by Михаил on 06.04.2024.
//

import UIKit
import PinLayout

protocol OtherCollectionViewCellDelegate: AnyObject {
    func otherTypeCollectionViewCellDidSelectItem(type: Other)
}

final class OtherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - private properties
    
    weak var delegate: OtherCollectionViewCellDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Ghost")
        collectionView.register(OtherCell.self, forCellWithReuseIdentifier: "OtherCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
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
            .height(50)
        
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
        label.text = "Другое"
        label.textColor = UIColor(named: "SpaceGray")
    }
    
    func configure(with model: OtherTypeViewModel) {
    }
}

// MARK: - Collection View data source

extension OtherCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCell", for: indexPath) as? OtherCell else {
            return .init()
        }
        
        let imageNames = ["charge", "kegel", "eye"]
        let imageName = imageNames[indexPath.item]
        
        if let image = UIImage(named: imageName) {
            cell.setImage(with: image, indexPath: indexPath)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       3
    }
}

// MARK: - Collection View FlowLayout delegate

extension OtherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (contentView.frame.width / 3) - 16 / 3 - 2
        return CGSize(width: w, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
}

// MARK: - Collection View delegate

extension OtherCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OtherCell else {
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
            delegate?.otherTypeCollectionViewCellDidSelectItem(type: .charge)
        case 1:
            delegate?.otherTypeCollectionViewCellDidSelectItem(type: .kegel)
        case 2:
            delegate?.otherTypeCollectionViewCellDidSelectItem(type: .eye)
        default:
            return
        }
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? OtherCell {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? OtherCell {
                cell.transform = CGAffineTransform.identity
            }
        }
    }
}
