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
            .top(view.pin.safeArea)
            .marginTop(40)
            .horizontally(20)
            .height(30)

        tableView.pin
            .below(of: finishButton)
            .marginTop(170)
            .horizontally()
            .bottom()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupFinishButton()
        setupTableView()
        
        view.addSubviews(finishButton, tableView)
    }

    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingTableViewCell.self, forCellReuseIdentifier: TrainingTableViewCell.reuseID)
        tableView.rowHeight = 80
    }
    
    func setupFinishButton() {
        finishButton.backgroundColor = .systemMint
        finishButton.addTarget(self, action: #selector(didTapFinishButton), for: .touchUpInside)
        finishButton.isHidden = true
    }
    
    // MARK: - Actions
    
    @objc
    func didTapStartButton(_ button: UIButton) {
        output.didTapStartButton(number: button.tag)
    }
    
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
        
        cell.configure(with: output.getExercise(at: indexPath.row), and: indexPath.row)
        cell.addStartButtonTarget(self, action: #selector(didTapStartButton))
        cell.delegate = self
        
        if output.getSwitchState(at: indexPath.row) {
            cell.checkCheckBox()
        } else {
            cell.uncheckCheckBox()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - SwitchTableViewCellDelegate

extension TrainingViewController: SwitchTableViewCellDelegate {
    func switchCell(_ cell: TrainingTableViewCell, with value: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        output.setSwitchState(at: indexPath.row, with: value)
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
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            self.tableView.reloadData()
        }
    }
}
