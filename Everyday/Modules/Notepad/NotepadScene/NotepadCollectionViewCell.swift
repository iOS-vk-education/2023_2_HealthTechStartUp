//
//  NotepadCollectionViewCell.swift
//  Everyday
//
//  Created by Alexander on 06.04.2024.
//

import UIKit
import PinLayout

// MARK: - Delegate Protocol

protocol NotepadCollectionViewCellDelegate: AnyObject {
    func didTapInnerCollectionViewCell(_ date: Date)
}

class NotepadCollectionViewCell: UICollectionViewCell {
    static let reuseID = "NotepadCollectionViewCell"
    
    weak var delegate: NotepadCollectionViewCellDelegate?
    
    private var innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var week: [Date] = []
    private(set) var selectedCellIndexPath: IndexPath?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    // MARK: - Interface
    
    func configure(with week: [Date], and selectedCellIndexPath: IndexPath? = nil) {
        self.week = week
        self.selectedCellIndexPath = selectedCellIndexPath
        innerCollectionView.reloadData()
        
        selectCollectionViewCellsIfNeeded()
    }
    
    func deselectCell() {
        if let indexPath = selectedCellIndexPath {
            innerCollectionView.deselectItem(at: indexPath, animated: false)
            selectedCellIndexPath = nil
        }
    }
}

private extension NotepadCollectionViewCell {
    
    // MARK: - Layout
    
    func layout() {
        innerCollectionView.pin.all()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupCollectionView()
        
        addSubview(innerCollectionView)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupCollectionView() {
        innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSevenColumnFlowLayout(in: self))
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        innerCollectionView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutCollectionViewCell.reuseID)
        
        innerCollectionView.backgroundColor = Constants.InnerCollectionView.backgroundColor
        
        innerCollectionView.showsHorizontalScrollIndicator = false
        innerCollectionView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Helpers
    
    func selectCollectionViewCellsIfNeeded() {
        for indexPath in innerCollectionView.indexPathsForSelectedItems ?? [] {
            innerCollectionView.deselectItem(at: indexPath, animated: false)
        }
        innerCollectionView.selectItem(at: selectedCellIndexPath, animated: false, scrollPosition: [])
    }
}

// MARK: - CollectionViewDataSource

extension NotepadCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        week.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCollectionViewCell.reuseID, 
                                                            for: indexPath) as? WorkoutCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let date = week[indexPath.item]
        cell.configure(with: date)
        
        return cell
    }
}

// MARK: - CollectionViewDelegate

extension NotepadCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCellIndexPath != indexPath {
            delegate?.didTapInnerCollectionViewCell(week[indexPath.item])
            selectedCellIndexPath = indexPath
        }
    }
}

// MARK: - Constants

private extension NotepadCollectionViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .clear
        
        struct InnerCollectionView {
            static let backgroundColor: UIColor = .clear
        }
    }
}
