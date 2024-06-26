//
//  EmptyStateView.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit
import PinLayout

final class EmptyStateView: UIView {
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
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
    
    func configure(with viewModel: NotepadEmptyStateViewModel) {
        imageView.image = viewModel.logoImage
        titleLabel.attributedText = viewModel.title
    }
}

private extension EmptyStateView {
    
    // MARK: - Layout
    
    func layout() {
        imageView.pin
            .top(Constants.ImageView.marginTop)
            .height(Constants.ImageView.size)
            .width(Constants.ImageView.size)
            .hCenter()
        
        titleLabel.pin
            .below(of: imageView)
            .height(Constants.TitleLabel.height)
            .horizontally()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupLabel()
        addSubviews(imageView, titleLabel)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupLabel() {
        titleLabel.textAlignment = .center
    }
}

// MARK: - Constants

private extension EmptyStateView {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct ImageView {
            static let marginTop: CGFloat = 100
            static let size: CGFloat = 300
        }
        
        struct TitleLabel {
            static let height: CGFloat = 36
        }
    }
}
