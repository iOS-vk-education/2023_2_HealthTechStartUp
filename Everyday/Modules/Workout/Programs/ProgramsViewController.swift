//
//  ProgramsViewController.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import UIKit
import PinLayout

final class ProgramsViewController: UIViewController {
    // MARK: - private properties
    
    private let output: ProgramsViewOutput
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "Ghost")
        return collectionView
    }()
    
    private lazy var collectionViewManager = ProgramsCollectionManager(collectionView: self.collectionView)
        
    // MARK: - lifecycle
    
    init(output: ProgramsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Ghost")
                
        setupUI()
        output.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        arrangement()
    }
    
    // MARK: - SetUp
    
    private func setupUI() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Layout
    
    private func arrangement() {
        collectionView.pin.all()
    }
}

extension ProgramsViewController: ProgramsViewInput {
    func setup(with items: [ProgramsSectionItem]) {
        collectionViewManager.reload(with: items)
    }
}
