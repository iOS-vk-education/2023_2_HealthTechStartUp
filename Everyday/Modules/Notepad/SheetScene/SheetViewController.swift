//
//  SheetViewController.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import UIKit

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
    
    convenience init(output: SheetViewOutput, type: SheetType) {
        self.init(output: output)
        
        let contentView: UIView?
        switch type {
        case .weightMeasurement(let weightMeasurementViewModel):
            contentView = WeightMeasureView(weight: weightMeasurementViewModel.weight)
        case .conditionChoice(let conditionChoiceViewModel):
            contentView = ConditionChoiceView(condition: conditionChoiceViewModel.condition)
        case .heartRateVariability(let heartRateVariabilityViewModel):
            contentView = UIView()  // fix this
        case .camera(let cameraViewModel):
            contentView = CameraView()
        }
        guard let contentView else {
            // handle this case
            return
        }
        
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
        setupCloseButton()
        setupSaveButton()
    }
    
    func setupView() {
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubviews(closeButton, saveButton, contentView)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
    }
}

// MARK: - ViewInput

extension SheetViewController: SheetViewInput {
    func configure(with viewModel: SheetViewModel) {
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
}

// MARK: - Constants

private extension SheetViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct Button {
            static let backgroundColor: UIColor = .UI.accent
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
}
