//
//  UIHelper.swift
//  Everyday
//
//  Created by Alexander on 04.04.2024.
//

import UIKit

enum UIHelper {
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let availableWidth = width
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: 60)
        flowLayout.minimumLineSpacing = 0
        
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
    
    static func createSevenColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let minimumItemSpacing: CGFloat = 12
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 6)
        let itemWidth = availableWidth / 7
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding + 5, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 60)
        
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
    
    static func createHorizontalFlowLayout(in view: UIView, with numberOfItems: Int) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
}
