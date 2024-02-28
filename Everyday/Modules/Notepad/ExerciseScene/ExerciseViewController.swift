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
            .marginTop(300)
            .horizontally(20)
            .height(30)
        
        counterStepper.pin
            .below(of: resultLabel)
            .hCenter()
            .width(100)
            .height(40)
        
        saveButton.pin
            .below(of: counterStepper)
            .marginTop(40)
            .hCenter()
            .width(100)
            .height(40)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupResultLabel()
        setupStepper()
        setupButton()
        
        view.addSubviews(resultLabel, counterStepper, saveButton)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupResultLabel() {
        resultLabel.textAlignment = .center
    }
    
    func setupStepper() {
        counterStepper.addTarget(self, action: #selector(didTapStepper), for: .touchUpInside)
    }
    
    func setupButton() {
        saveButton.backgroundColor = .systemBlue
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
