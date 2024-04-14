//
//  SheetBaseView.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit
import PinLayout

class SheetBaseView: UIView {
    
    // MARK: - Private Properties
    
    private let containerView = UIView()
    private var contentView: UIView!
    
    let closeButton = UIButton()
    let saveButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(with: SheetBaseViewModel())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(with: SheetBaseViewModel())
    }
    
    convenience init(contentView: UIView) {
        self.init(frame: .zero)
        self.contentView = contentView
        setup()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
}

private extension SheetBaseView {
    
    // MARK: - Layout
    
    func layout() {
        containerView.pin
            .all()
        
        closeButton.pin
            .top(Constants.Button.padding)
            .left(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        saveButton.pin
            .top(Constants.Button.padding)
            .right(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        contentView.pin
            .below(of: [closeButton, saveButton])
            .bottom()
            .horizontally()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupContainerView()
        setupCloseButton()
        setupSaveButton()
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        
        addSubview(containerView)
    }
    
    func setupContainerView() {
        containerView.backgroundColor = Constants.ContainerView.backgroundColor
        
        containerView.addSubviews(closeButton, saveButton, contentView)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: SheetBaseViewModel) {
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
}

// MARK: - Constants

private extension SheetBaseView {
    struct Constants {
        static let backgroundColor: UIColor = .clear
        
        struct ContainerView {
            static let backgroundColor: UIColor = .background
        }
        
        struct Button {
            static let backgroundColor: UIColor = .UI.accent
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
}
