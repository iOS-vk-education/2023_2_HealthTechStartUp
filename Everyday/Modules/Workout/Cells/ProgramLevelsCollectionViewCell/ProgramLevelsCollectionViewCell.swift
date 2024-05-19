//
//  ProgramLevelsCollectionViewCell.swift
//  workout
//
//  Created by Михаил on 01.04.2024.
//

import UIKit
import PinLayout

protocol LevelCollectionViewCellDelegate: AnyObject {
    func levelTypeCollectionViewCellDidSelectItem(type: Level)
}

final class ProgramLevelsCollectionViewCell: UICollectionViewCell {
    // MARK: - private properties
    
    weak var delegate: LevelCollectionViewCellDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var layout = {
        let layout = LevelCellFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 20
        layout.itemSize.width = 180
        return layout
    }()
    
    private let label = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Ghost")
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: "LevelCell")
        return collectionView
    }()
    
    var isFirstTime = true
    
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
        label.text = "Сложность тренировок"
        label.textColor = UIColor(named: "SpaceGray")
    }
    
    func configure(with model: ProgramLevelsViewModel) {
    }
}

// MARK: - Collection View data source

extension ProgramLevelsCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as? LevelCell else {
            return .init()
        }
        
        let imageNames = ["easy", "medium", "pro"]
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

extension ProgramLevelsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 180, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
}

// MARK: - Collection View delegate

extension ProgramLevelsCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == layout.currentPage {            
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            layout.currentPage = indexPath.item
            layout.previousOffset = layout.updateOffset(collectionView)
            setupCell()
        }
        
        switch indexPath.row {
        case 0:
            delegate?.levelTypeCollectionViewCellDidSelectItem(type: .easy)
        case 1:
            delegate?.levelTypeCollectionViewCellDidSelectItem(type: .medium)
        case 2:
            delegate?.levelTypeCollectionViewCellDidSelectItem(type: .pro)
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFirstTime {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                let indexPath = IndexPath(item: 1, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

                self.layout.currentPage = indexPath.item
                self.layout.previousOffset = self.layout.updateOffset(collectionView)

                if let cell = collectionView.cellForItem(at: indexPath) {
                    self.transformCell(cell)
                }
                self.isFirstTime = false
            }
        }
    }
}

// MARK: - ScrollView Delegate

extension ProgramLevelsCollectionViewCell {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    private func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        for otherCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: otherCell) {
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
}
