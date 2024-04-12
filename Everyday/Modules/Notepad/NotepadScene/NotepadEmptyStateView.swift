//
//  NotepadEmptyStateView.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import UIKit
import PinLayout

class NotepadEmptyStateView: UIView {
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
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
        setupLabel()
        
        addSubviews(imageView, titleLabel)
    }
    
    func setupLabel() {
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Configure
    
    func configure() {
        let viewModel = NotepadEmptyStateViewViewModel()
        imageView.image = viewModel.logoImage
        titleLabel.attributedText = viewModel.title
    }
}

private extension NotepadEmptyStateView {
    struct Constants {
        struct ImageView {
            static let marginTop: CGFloat = 100
            static let size: CGFloat = 300
        }
        
        struct TitleLabel {
            static let height: CGFloat = 36
        }
    }
}
