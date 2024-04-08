//
//  TrainingViewController.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit
import PinLayout

final class TrainingViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: TrainingViewOutput
    
    private let finishButton = UIButton()
    private let tableView = UITableView()
    
    // MARK: - Init

    init(output: TrainingViewOutput) {
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

private extension TrainingViewController {
    // MARK: - Layout
    
    func layout() {
        finishButton.pin
            .bottom(view.pin.safeArea)
            .horizontally(Constants.FinishButton.horizontalMargin)
            .height(Constants.FinishButton.height)

        tableView.pin
            .top(view.pin.safeArea)
            .above(of: finishButton)
            .horizontally()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupFinishButton()
        setupTableView()
        
        view.addSubviews(finishButton, tableView)
    }

    func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setupTableView() {
        tableView.backgroundColor = Constants.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingTableViewCell.self, forCellReuseIdentifier: TrainingTableViewCell.reuseID)
        tableView.rowHeight = Constants.TableView.rowHeight
    }
    
    func setupFinishButton() {
        finishButton.backgroundColor = Constants.FinishButton.backgroundColor
        finishButton.layer.cornerRadius = Constants.FinishButton.cornerRadius
        finishButton.addTarget(self, action: #selector(didTapFinishButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapFinishButton() {
        output.didTapFinishButton()
    }
}

// MARK: - UITableViewDataSource

extension TrainingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainingTableViewCell.reuseID, for: indexPath) as? TrainingTableViewCell else {
            return UITableViewCell()
        }
        
        let exercise = output.getExercise(at: indexPath.row)
        let viewModel = TrainingTableViewCellViewModel(exercise: exercise)
        let isDone = output.getSwitchState(at: indexPath.row)
        
        cell.configure(with: viewModel, and: indexPath.row, isDone: isDone)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - TrainingViewInput

extension TrainingViewController: TrainingViewInput {
    func configure(with viewModel: TrainingViewModel) {
        finishButton.setAttributedTitle(viewModel.finishTitle, for: .normal)
    }
    
    func showFinishButton() {
        finishButton.isHidden = false
    }
    
    func hideFinishButton() {
        finishButton.isHidden = true
    }
    
    func reloadData() {    
        tableView.reloadData()
    }
}

// MARK: - Constants

private extension TrainingViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct FinishButton {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let cornerRadius: CGFloat = 16
            static let height: CGFloat = 40
            static let marginTop: CGFloat = 40
            static let horizontalMargin: CGFloat = 20
        }
        
        struct TableView {
            static let marginTop: CGFloat = 170
            static let rowHeight: CGFloat = 80
        }
    }
}
