//
//  ExerciseViewController.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit
import PinLayout

final class ExerciseViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: ExerciseViewOutput
    
    private let resultLabel = UILabel()
    private let counterStepper = UIStepper()
    private let saveButton = UIButton()
    
    // MARK: - Init

    init(output: ExerciseViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.didLoadView()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

private extension ExerciseViewController {
    
    // MARK: - Layout
    
    func layout() {
        resultLabel.pin
            .top(view.pin.safeArea)
            .marginTop(Constants.ResultLabel.marginTop)
            .horizontally(Constants.horizontalMargin)
            .height(Constants.contentHeight)
        
        counterStepper.pin
            .below(of: resultLabel)
            .width(Constants.CounterStepper.width)
            .height(Constants.contentHeight)
            .hCenter()
        
        saveButton.pin
            .below(of: counterStepper)
            .marginTop(Constants.SaveButton.marginTop)
            .width(Constants.SaveButton.width)
            .height(Constants.contentHeight)
            .hCenter()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupResultLabel()
        setupStepper()
        setupSaveButton()
        
        view.addSubviews(resultLabel, counterStepper, saveButton)
    }
    
    func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setupResultLabel() {
        resultLabel.textAlignment = .center
    }
    
    func setupStepper() {
        counterStepper.addTarget(self, action: #selector(didTapStepper), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        saveButton.backgroundColor = Constants.SaveButton.backgroundColor
        saveButton.layer.cornerRadius = Constants.SaveButton.cornerRadius
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }

    // MARK: - Actions
    
    @objc
    func didTapStepper() {
        let counterValue = Int(counterStepper.value).description
        output.didTapStepper(with: counterValue)
    }
    
    @objc
    func didTapSaveButton() {
        output.didTapSaveButton()
    }
}

// MARK: - ExerciseViewInput

extension ExerciseViewController: ExerciseViewInput {
    func configure(with viewModel: ExerciseViewModel) {
        title = viewModel.title
        resultLabel.attributedText = viewModel.resultTitle
        saveButton.setAttributedTitle(viewModel.saveTitle, for: .normal)
    }
    
    func updateResult(with result: String) {
        resultLabel.text = result
    }
}

// MARK: - Constants

private extension ExerciseViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        static let horizontalMargin: CGFloat = 20
        static let contentHeight: CGFloat = 40
        
        struct ResultLabel {
            static let marginTop: CGFloat = 300
        }
        
        struct CounterStepper {
            static let width: CGFloat = 100
        }
        
        struct SaveButton {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let cornerRadius: CGFloat = 16
            static let width: CGFloat = 100
            static let marginTop: CGFloat = 40
        }
    }
}
