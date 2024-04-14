//
//  NotepadEmptyStateView.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import UIKit
import PinLayout

final class NotepadEmptyStateView: UIView {
    
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
    
    // MARK: - Configure
    
    func configure(with viewModel: EmptyStateViewViewModel) {
        imageView.image = viewModel.logoImage
        titleLabel.attributedText = viewModel.title
    }
}

private extension NotepadEmptyStateView {
    
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
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        addSubviews(imageView, titleLabel)
    }
    
    func setupLabel() {
        titleLabel.textAlignment = .center
    }
}

// MARK: - Constants

private extension NotepadEmptyStateView {
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
