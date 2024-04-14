//
//  SheetViewController.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import UIKit
import PinLayout

final class SheetViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let output: SheetViewOutput
    
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    private var contentView = UIView()
    
    // MARK: - Init

    init(output: SheetViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(output: SheetViewOutput, contentView: UIView) {
        self.init(output: output)
        self.contentView = contentView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        output.didLoadView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

private extension SheetViewController {
    
    // MARK: - Layout
    
    func layout() {
        closeButton.pin
            .top(Constants.Button.padding + view.pin.safeArea.top)
            .left(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        saveButton.pin
            .top(Constants.Button.padding + view.pin.safeArea.top)
            .right(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        contentView.pin
            .below(of: [closeButton, saveButton])
            .marginTop(Constants.Button.padding)
            .bottom()
            .horizontally()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupCloseButton()
        setupSaveButton()
        view.addSubviews(closeButton, saveButton, contentView)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }

    // MARK: - Actions
    
    @objc
    func didTapCloseButton() {
        output.didTapCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        output.didTapSaveButton()
    }
}

// MARK: - ViewInput

extension SheetViewController: SheetViewInput {
    func configure(with viewModel: SheetViewModel) {
        view.backgroundColor = viewModel.backgroundColor
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
}

// MARK: - Constants

private extension SheetViewController {
    struct Constants {
        struct Button {
            static let backgroundColor: UIColor = .UI.accent
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
}
