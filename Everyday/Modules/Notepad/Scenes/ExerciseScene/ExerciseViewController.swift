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
    
    private let resultView = UIView()
    private let resultLabel = UILabel()
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

private extension ExerciseViewController {
    
    // MARK: - Layout
    
    func layout() {
        let resultViewWidth: CGFloat = view.bounds.width - Constants.ResultView.padding * 2
        
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
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupResultView()
        setupResultLabel()
        setupPlusButton()
        setupMinusButton()
        setupCloseButton()
        setupSaveButton()
        
        resultView.addSubview(resultLabel)
        view.addSubviews(plusButton, minusButton, closeButton, resultView, saveButton)
    }
    
    func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setupResultView() {
        resultView.backgroundColor = Constants.ResultView.backgroundColor
        resultView.layer.cornerRadius = Constants.ResultView.cornerRadius
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
        output.didTapMinusButton()
    }
    
    @objc
    func didTapPlusButton() {
        output.didTapPlusButton()
    }
    
    @objc
    func didTapCloseButton() {
        output.didTapCloseButton()
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
        minusButton.setImage(viewModel.minusImage, for: .normal)
        plusButton.setImage(viewModel.plusImage, for: .normal)
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
    
    func updateResult(with result: String) {
        resultLabel.text = result
    }
}

// MARK: - Constants

private extension ExerciseViewController {
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
