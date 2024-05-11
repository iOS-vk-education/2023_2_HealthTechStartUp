//
//  ExerciseCounterView.swift
//  Everyday
//
//  Created by Alexander on 10.05.2024.
//

import UIKit
import PinLayout

final class ExerciseCounterView: UIView {
    
    // MARK: - Private Properties

    private var output: ExerciseCounterViewOutput?
    
    private let resultView = UIView()
    private let resultLabel = UILabel()
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    
    private var exercise: Exercise?
    private var result: Int = 0
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(exercise: Exercise, output: ExerciseCounterViewOutput?) {
        self.init(frame: .zero)
        self.exercise = exercise
        self.output = output
        
        let viewModel = ExerciseCounterViewModel(exercise: exercise)
        resultLabel.attributedText = viewModel.resultTitle
        minusButton.setImage(viewModel.minusImage, for: .normal)
        plusButton.setImage(viewModel.plusImage, for: .normal)
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension ExerciseCounterView {
    
    // MARK: - Layout
    
    func layout() {
        let resultViewWidth: CGFloat = bounds.width - Constants.ResultView.padding * 2
        
        resultView.pin
            .width(resultViewWidth)
            .height(Constants.ResultView.height)
            .hCenter()
            .top(Constants.ResultView.marginTop)
        
        resultLabel.pin
            .hCenter()
            .vCenter()
            .height(Constants.ResultLabel.height)
            .width(Constants.ResultLabel.width)
        
        plusButton.pin
            .below(of: resultView)
            .right(Constants.Button.horizontalMargin)
            .height(Constants.Button.height)
            .width(Constants.Button.width)
        
        minusButton.pin
            .below(of: resultView)
            .left(Constants.Button.horizontalMargin)
            .height(Constants.Button.height)
            .width(Constants.Button.width)
        
        closeButton.pin
            .top(Constants.CloseButton.padding)
            .left(Constants.CloseButton.padding)
            .width(Constants.CloseButton.width)
            .height(Constants.CloseButton.height)
        
        saveButton.pin
            .top(Constants.CloseButton.padding)
            .right(Constants.CloseButton.padding)
            .width(Constants.CloseButton.width)
            .height(Constants.CloseButton.height)
    }
    
    // MARK: - Configure
    
    func configureButtons() {
        let viewModel = SheetViewModel()
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupResultView()
        setupResultLabel()
        setupPlusButton()
        setupMinusButton()
        setupCloseButton()
        setupSaveButton()
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        addSubviews(plusButton, minusButton, closeButton, resultView, saveButton)
    }
    
    func setupResultView() {
        resultView.backgroundColor = Constants.ResultView.backgroundColor
        resultView.layer.cornerRadius = Constants.ResultView.cornerRadius
        resultView.addSubview(resultLabel)
    }
    
    func setupResultLabel() {
        resultLabel.textAlignment = .center
    }
    
    func setupMinusButton() {
        minusButton.tintColor = Constants.Button.backgroundColor
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    func setupPlusButton() {
        plusButton.tintColor = Constants.Button.backgroundColor
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
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
    func didTapMinusButton() {
        guard result > 0 else {
            return
        }
        
        result -= 1
        resultLabel.text = String(result)
    }
    
    @objc
    func didTapPlusButton() {
        result += 1
        resultLabel.text = String(result)
    }
    
    @objc
    func didTapCloseButton() {
        output?.didTapExerciseCounterCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        if var exercise {
            exercise.result = String(result)
            output?.didTapExerciseCounterSaveButton(with: exercise)
        } else {
            output?.didTapExerciseCounterCloseButton()  // handle properly
        }
    }
}

// MARK: - Constants

private extension ExerciseCounterView {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct Button {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let width: CGFloat = 100
            static let height: CGFloat = 100
            static let horizontalMargin: CGFloat = 50
        }
        
        struct ResultView {
            static let backgroundColor: UIColor = UIColor.Text.primary
            static let padding: CGFloat = 32
            static let cornerRadius: CGFloat = 16
            static let marginTop: CGFloat = 75
            static let height: CGFloat = 100
        }
        
        struct ResultLabel {
            static let width: CGFloat = 300
            static let height: CGFloat = 80
        }
        
        struct CloseButton {
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
}
