//
//  ResultsViewController.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import UIKit
import PinLayout

final class ResultsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: ResultsViewOutput
    
    private let backgroundView = UIView()
    private let contentView = UIView()
    private let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private let restButton = UIButton()
    private let continueButton = UIButton()
    
    // MARK: - Init

    init(output: ResultsViewOutput) {
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
        super.viewDidLayoutSubviews()
        
        layout()
    }
}

private extension ResultsViewController {
    
    // MARK: - Layout
    
    func layout() {
        backgroundView.pin
            .all()
        
        closeButton.pin
            .top(Constants.CloseButton.padding)
            .left(Constants.CloseButton.padding)
            .width(Constants.CloseButton.width)
            .height(Constants.CloseButton.height)
        
        titleLabel.pin
            .top()
            .height(Constants.TitleLabel.height)
            .left()
            .right()
        
        restButton.pin
            .bottom(Constants.marginBottom)
            .height(Constants.contentHeight)
            .left(Constants.horizontalMargin)
            .width(Constants.RestButton.width)
        
        continueButton.pin
            .bottom(Constants.marginBottom)
            .height(Constants.contentHeight)
            .after(of: restButton)
            .marginLeft(Constants.ContinueButton.marginLeft)
            .right(Constants.horizontalMargin)
        
        tableView.pin
            .below(of: titleLabel)
            .above(of: restButton)
            .left()
            .right()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupBackgroundView()
        setupContentView()
        setupTableView()
        setupCloseButton()
        setupTitleLabel()
        setupRestButton()
        setupContinueButton()
        
        contentView.addSubviews(tableView, closeButton, restButton, continueButton, titleLabel)
        view.addSubviews(backgroundView, contentView)
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupTableView() {
        tableView.backgroundColor = Constants.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.reuseID)
    }
    
    func setupBackgroundView() {
        backgroundView.backgroundColor = .black.withAlphaComponent(0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCloseButton))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func setupContentView() {
        contentView.backgroundColor = Constants.backgroundColor
        
        let width: CGFloat = view.bounds.width - Constants.padding * 2
        let height: CGFloat = width
        
        let x = (view.bounds.width - width) / 2
        let y = (view.bounds.height - height) / 2
        
        contentView.frame = CGRect(x: x, y: y, width: width, height: height)
        contentView.layer.cornerRadius = Constants.cornerRadius
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        closeButton.tintColor = Constants.buttonColor
    }
    
    func setupRestButton() {
        restButton.backgroundColor = Constants.buttonColor
        restButton.layer.cornerRadius = Constants.cornerRadius
        restButton.addTarget(self, action: #selector(didTapRestButton), for: .touchUpInside)
    }
    
    func setupContinueButton() {
        continueButton.backgroundColor = Constants.buttonColor
        continueButton.layer.cornerRadius = Constants.cornerRadius
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    func setupTitleLabel() {
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Actions
    
    @objc
    func didTapCloseButton() {
        output.didTapCloseButton()
    }
    
    @objc
    func didTapRestButton() {
        output.didTapRestButton()
    }
    
    @objc
    func didTapContinueButton() {
        output.didTapContinueButton()
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.reuseID, for: indexPath) as? ResultsTableViewCell else {
            return UITableViewCell()
        }

        let exercise = output.getExercise(at: indexPath.row)
        let viewModel = ResultsTableViewCellViewModel(exercise: exercise)
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ResultsViewController: UITableViewDelegate {
}

// MARK: - ResultsViewInput

extension ResultsViewController: ResultsViewInput {
    func configure(with viewModel: ResultsViewModel) {
        titleLabel.attributedText = viewModel.resultsTitle
        restButton.setAttributedTitle(viewModel.restTitle, for: .normal)
        continueButton.setAttributedTitle(viewModel.continueTitle, for: .normal)
        closeButton.setImage(viewModel.closeImage, for: .normal)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Constants

private extension ResultsViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        static let buttonColor: UIColor = UIColor.UI.accent
        
        static let padding: CGFloat = 24
        static let cornerRadius: CGFloat = 16
        static let horizontalMargin: CGFloat = 40
        static let marginBottom: CGFloat = 20
        static let contentHeight: CGFloat = 40
        
        struct RestButton {
            static let width: CGFloat = 100
        }
        
        struct ContinueButton {
            static let marginLeft: CGFloat = 20
        }
        
        struct CloseButton {
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
        
        struct TitleLabel {
            static let height: CGFloat = 80
        }
    }
}
