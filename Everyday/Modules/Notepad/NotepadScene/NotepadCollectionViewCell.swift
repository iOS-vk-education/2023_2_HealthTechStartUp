//
//  NotepadCollectionViewCell.swift
//  Everyday
//
//  Created by Alexander on 06.04.2024.
//

import UIKit
import PinLayout

class NotepadCollectionViewCell: UICollectionViewCell {
    static let reuseID = "NotepadCollectionViewCell"
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var week: [Date] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    // MARK: - Interface
    
    func configure(with week: [Date]) {
        self.week = week
    }
}

private extension NotepadCollectionViewCell {
    
    // MARK: - Layout
    
    func layout() {
        collectionView.pin.all()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupCollectionView()
        
        addSubview(collectionView)
    }
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSevenColumnFlowLayout(in: self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutCollectionViewCell.reuseID)
        
        collectionView.backgroundColor = .clear
        
        collectionView.showsHorizontalScrollIndicator = false
    }
}

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

extension NotepadCollectionViewCell: UICollectionViewDelegate {}  // pending date selection handler
