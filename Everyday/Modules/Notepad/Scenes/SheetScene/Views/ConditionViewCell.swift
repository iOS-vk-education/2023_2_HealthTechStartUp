//
//  ConditionView.swift
//  Everyday
//
//  Created by Alexander on 13.04.2024.
//

import UIKit
import PinLayout

final class ConditionViewCell: UICollectionViewCell {
    static let reuseID = "ConditionViewCell"
    
    // MARK: - Private Properties
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                UIView.animate(withDuration: Constants.ImageView.animationDuration) { [weak self] in
                    guard let self else {
                        return
                    }
                    
                    imageView.transform = CGAffineTransform(scaleX: Constants.ImageView.scalingValue,
                                                            y: Constants.ImageView.scalingValue)
                    imageView.tintColor = Constants.ImageView.chosenTintColor
                    titleLabel.textColor = Constants.TitleLabel.chosenTextColor
                }
            } else {
                UIView.animate(withDuration: Constants.ImageView.animationDuration) { [weak self] in
                    guard let self else {
                        return
                    }
                    
                    titleLabel.textColor = Constants.TitleLabel.defaultTextColor
                    imageView.tintColor = Constants.ImageView.defaultTintColor
                    imageView.transform = .identity
                }
            }
        }
    }
    
    // MARK: - Interface
    
    func configure(with viewModel: ConditionCellViewModel) {
        imageView.image = viewModel.conditionImage
        titleLabel.attributedText = viewModel.title
    }
}

private extension ConditionViewCell {
    
    // MARK: - Layout
    
    func layout() {
        stackView.pin
            .vCenter()
            .horizontally()
            .height(80)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupStackView()
        setupImageView()
        setupTitleLabel()
        addSubview(stackView)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    func setupImageView() {
        imageView.tintColor = Constants.ImageView.defaultTintColor
    }
    
    func setupTitleLabel() {
        titleLabel.textAlignment = .center
    }
}

// MARK: - Constants

private extension ConditionViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct StackView {
            static let defaultBackgroundColor: UIColor = .Text.grayElement
            static let chosenBackgroundColor: UIColor = .UI.accent
        }
        
        struct ImageView {
            static let defaultTintColor: UIColor = .Text.grayElement
            static let chosenTintColor: UIColor = .UI.accent
            static let animationDuration: TimeInterval = 0.3
            static let scalingValue: CGFloat = 1.5
        }
        
        struct TitleLabel {
            static let defaultTextColor: UIColor = .Text.grayElement
            static let chosenTextColor: UIColor = .UI.accent
        }
    }
}
