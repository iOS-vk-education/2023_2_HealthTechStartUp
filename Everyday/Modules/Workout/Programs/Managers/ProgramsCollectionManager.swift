//
//  ProgramsCollectionManager.swift
//  workout
//
//  Created by Михаил on 25.03.2024.
//

import Foundation
import UIKit

final class ProgramsCollectionManager: NSObject {
    private var items: [ProgramsSectionItem] = []
    private weak var collectionView: UICollectionView?
    
    weak var targetDelegate: TargetCollectionViewCellDelegate?
    weak var trainingDelegate: TrainingTypeCollectionViewCellDelegate?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reload(with items: [ProgramsSectionItem]) {
        self.items = items
        registerCells()
        collectionView?.reloadData()
    }
    
    private func registerCells() {
        for item in items {
            switch item {
            case .trainingType:
                collectionView?.register(TrainingTypeCollectionViewCell.self, forCellWithReuseIdentifier: item.id)
                
            case .programLevelType:
                collectionView?.register(ProgramLevelsCollectionViewCell.self, forCellWithReuseIdentifier: item.id)
                
            case .targetType:
                collectionView?.register(TargetCollectionViewCell.self, forCellWithReuseIdentifier: item.id)
                
            case .otherType:
                collectionView?.register(OtherCollectionViewCell.self, forCellWithReuseIdentifier: item.id)
            }
        }
    }
}

extension ProgramsCollectionManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        
        switch item {
        case .trainingType(let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.id, for: indexPath) as? TrainingTypeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self.trainingDelegate
            cell.configure(with: info)
            return cell
            
        case .programLevelType(info: let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.id, for: indexPath) as? ProgramLevelsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: info)
            return cell
            
        case .targetType(info: let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.id, for: indexPath) as? TargetCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self.targetDelegate
            cell.configure(with: info)
            return cell
            
        case .otherType(info: let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.id, for: indexPath) as? OtherCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: info)
            return cell
        }
    }
}

extension ProgramsCollectionManager: UICollectionViewDelegate {   
}

// MARK: - Collection View FlowLayout delegate

extension ProgramsCollectionManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = items[indexPath.item]
        
        switch item {
        case .trainingType:
            return .init(width: collectionView.frame.width, height: 125)
            
        case .programLevelType:
            return .init(width: collectionView.frame.width, height: 272)
            
        case .targetType:
            return .init(width: collectionView.frame.width, height: 262)
            
        case .otherType:
            return .init(width: collectionView.frame.width, height: 180)
        }
    }
}
