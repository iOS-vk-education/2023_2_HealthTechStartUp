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
            .top(8)
            .right(8)
            .width(40)
            .height(40)
        
        titleLabel.pin
            .top()
            .height(80)
            .left()
            .right()
        
        restButton.pin
            .bottom(20)
            .height(40)
            .left(40)
            .width(100)
        
        continueButton.pin
            .bottom(20)
            .height(40)
            .after(of: restButton)
            .marginLeft(20)
            .right(40)
        
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
        contentView.backgroundColor = .white
        
        let width: CGFloat = view.bounds.width - 24 * 2
        let height: CGFloat = width
        
        let x = (view.bounds.width - width) / 2
        let y = (view.bounds.height - height) / 2
        
        contentView.frame = CGRect(x: x, y: y, width: width, height: height)
        contentView.layer.cornerRadius = 16
    }
    
    func setupCloseButton() {
        closeButton.setTitle("", for: .normal)
        let buttonImageConfiguration = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let buttonImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: buttonImageConfiguration)
        closeButton.setImage(buttonImage, for: .normal)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        closeButton.tintColor = .systemMint
    }
    
    func setupRestButton() {
        restButton.backgroundColor = .systemMint
        restButton.layer.cornerRadius = 16
        restButton.addTarget(self, action: #selector(didTapRestButton), for: .touchUpInside)
    }
    
    func setupContinueButton() {
        continueButton.backgroundColor = .systemMint
        continueButton.layer.cornerRadius = 16
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
        cell.configure(with: exercise)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ResultsViewController: UITableViewDelegate {
}

// MARK: - ResultsViewInput

extension ResultsViewController: ResultsViewInput {
    func configure(with viewModel: ResultsViewModel) {
        titleLabel.attributedText = viewModel.title
        restButton.setAttributedTitle(viewModel.restTitle, for: .normal)
        continueButton.setAttributedTitle(viewModel.continueTitle, for: .normal)
    }
    
    func getSelf() -> ResultsViewController {
        return self
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            self.tableView.reloadData()
        }
    }
}
