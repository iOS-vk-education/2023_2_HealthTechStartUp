//
//  ConditionChoiceView.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit
import PinLayout

class ConditionChoiceView: UIView {
    
    // MARK: - Private Properties
    
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let selectedConditionIndex: Int? = nil
    private var output: ConditionChoiceViewOutput?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(condition: Condition? = nil, output: ConditionChoiceViewOutput?) {
        self.init(frame: .zero)
        self.output = output
        
        selectCollectionViewCellsIfNeeded(condition: condition)
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
        closeButton.pin
            .top(Constants.Button.padding + pin.safeArea.top)
            .left(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        saveButton.pin
            .top(Constants.Button.padding + pin.safeArea.top)
            .right(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        collectionView.pin
            .below(of: [closeButton, saveButton])
            .marginTop(Constants.Button.padding)
            .bottom(pin.safeArea)
            .horizontally()
    }
    
    // MARK: - Configure
    
    func configureButtons() {
        let viewModel = SheetViewModel()
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupCloseButton()
        setupSaveButton()
        configureButtons()
        setupView()
        setupCollectionView()
        addSubviews(closeButton, saveButton, collectionView)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHorizontalFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ConditionViewCell.self, forCellWithReuseIdentifier: ConditionViewCell.reuseID)
        
        collectionView.backgroundColor = Constants.CollectionView.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Actions
    
    @objc
    func didTapCloseButton() {
        output?.didTapConditionChoiceCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        guard
            let indexPathsForSelectedItems = collectionView.indexPathsForSelectedItems,
            let selectedIndexPath = indexPathsForSelectedItems.first
        else {
            output?.didTapSaveButton(with: nil)
            return
        }
        let selectedIndex = selectedIndexPath.item
        let condition = Condition.allCases[selectedIndex]
        output?.didTapSaveButton(with: condition)
    }
    
    // MARK: - Helpers
    
    func selectCollectionViewCellsIfNeeded(condition: Condition?) {
        if
            let condition = condition,
            let index = Condition.allCases.firstIndex(of: condition)
        {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ConditionChoiceView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return false
        }
        
        if cell.isSelected {
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        } else {
            return true
        }
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

// MARK: - Constants

private extension ConditionChoiceView {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct Button {
            static let backgroundColor: UIColor = .UI.accent
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
        
        struct CollectionView {
            static let backgroundColor: UIColor = .clear
            static let width: CGFloat = 40
            static let height: CGFloat = 100
        }
    }
}
