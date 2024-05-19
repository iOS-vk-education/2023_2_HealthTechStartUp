//
//  LevelCellFlowLayout.swift
//  workout
//
//  Created by Михаил on 01.04.2024.
//

import UIKit

class LevelCellFlowLayout: UICollectionViewFlowLayout {
    var previousOffset: CGFloat = 0.0
    var currentPage = 0
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0.0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0.0 {
            currentPage = min(currentPage + 1, itemCount - 1)
        }
        
        let offset = updateOffset(collectionView)
        previousOffset = offset
        
        return CGPoint(x: offset, y: proposedContentOffset.y)
    }
    
    func updateOffset(_ collectionView: UICollectionView) -> CGFloat {
        let width = collectionView.frame.width
        let itemWidth = itemSize.width
        let spacing = minimumLineSpacing
        let edge = (width - itemWidth - spacing * 2) / 2
        let offset = (itemWidth + spacing) * CGFloat(currentPage) - (edge + spacing)

        return offset
    }
}
