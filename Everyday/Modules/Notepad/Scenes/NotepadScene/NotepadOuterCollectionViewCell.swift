//
//  NotepadOuterCollectionViewCell.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import UIKit
import PinLayout

// MARK: - Delegate Protocol

protocol NotepadOuterCollectionViewCellDelegate: AnyObject {
    func didTapInnerCollectionViewCell(_ date: Date, _ outerIndexPath: IndexPath, _ innerIndexPath: IndexPath)
}

class NotepadOuterCollectionViewCell: UICollectionViewCell {
    static let reuseID = "NotepadOuterCollectionViewCell"
    
    weak var delegate: NotepadOuterCollectionViewCellDelegate?
    
    var innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var selfIndexPath: IndexPath?
    
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

private extension NotepadOuterCollectionViewCell {
    
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
        innerCollectionView.register(NotepadInnerCollectionViewCell.self, forCellWithReuseIdentifier: NotepadInnerCollectionViewCell.reuseID)
        
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

extension NotepadOuterCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        week.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotepadInnerCollectionViewCell.reuseID,
                                                            for: indexPath) as? NotepadInnerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let date = week[indexPath.item]
        let viewModel = NotepadInnerCollectionViewCellViewModel(date: date)
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - CollectionViewDelegate

extension NotepadOuterCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCellIndexPath != indexPath {
            delegate?.didTapInnerCollectionViewCell(week[indexPath.item], selfIndexPath!, indexPath)
            selectedCellIndexPath = indexPath
        }
    }
}

// MARK: - Constants

private extension NotepadOuterCollectionViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .clear
        
        struct InnerCollectionView {
            static let backgroundColor: UIColor = .clear
        }
    }
}
