//
//  ConditionChoiceView.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit
import PinLayout

class ConditionChoiceView: UIView {
    
    var output: ConditionChoiceViewOutput?
    
    // MARK: - Private Properties
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let selectedConditionIndex: Int? = nil
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(condition: Condition? = nil, output: ConditionChoiceViewOutput) {
        self.init(frame: .zero)
        self.output = output
        
        if
            let condition = condition,
            let index = Condition.allCases.firstIndex(of: condition)
        {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.selectItem(at: indexPath, 
                                      animated: false,
                                      scrollPosition: .centeredHorizontally)
        }
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension ConditionChoiceView {
    
    // MARK: - Layout
    
    func layout() {
        collectionView.pin
            .horizontally()
            .top()
            .bottom(pin.safeArea)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupCollectionView()
        addSubview(collectionView)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupCollectionView() {
        let numberOfItems = Condition.allCases.count
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHorizontalFlowLayout(in: self, with: numberOfItems))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ConditionViewCell.self, forCellWithReuseIdentifier: ConditionViewCell.reuseID)
        
        collectionView.backgroundColor = Constants.CollectionView.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDelegate

extension ConditionChoiceView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectItemAt(index: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConditionChoiceView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.width
        let height = bounds.height - pin.safeArea.bottom
        let padding: CGFloat = 8
        let minimumItemSpacing: CGFloat = 12
        let numberOfItems = Condition.allCases.count
        let numberOfSpacers = CGFloat(numberOfItems - 1)
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * numberOfSpacers)
        let itemWidth = availableWidth / CGFloat(numberOfItems)
        
        return CGSize(width: itemWidth, height: height)
    }
}

// MARK: - UICollectionViewDataSource

extension ConditionChoiceView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Condition.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConditionViewCell.reuseID, for: indexPath) as? ConditionViewCell else {
            return UICollectionViewCell()
        }
        
        let viewModel = ConditionCellViewModel(condition: Condition.allCases[indexPath.item])
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - ViewInput

protocol ConditionChoiceViewInput: AnyObject {
}

extension ConditionChoiceView: ConditionChoiceViewInput {
}

// MARK: - Constants

private extension ConditionChoiceView {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct CollectionView {
            static let backgroundColor: UIColor = .clear
            static let width: CGFloat = 40
            static let height: CGFloat = 100
        }
    }
}
