//
//  NotepadViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit
import PinLayout

final class NotepadViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: NotepadViewOutput
    
    private let stateLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Init

    init(output: NotepadViewOutput) {
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

private extension NotepadViewController {
    
    // MARK: - Layout
    
    func layout() {
        stateLabel.pin
            .top(view.pin.safeArea).marginTop(200)
            .horizontally(20)
            .height(30)

        tableView.pin
            .below(of: stateLabel)
            .marginTop(10)
            .horizontally()
            .bottom()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupTableView()
        
        view.addSubviews(stateLabel, tableView)
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dateLabel())
    }
    
    func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotepadTableViewCell.self, forCellReuseIdentifier: NotepadTableViewCell.reuseID)
    }
    
    func dateLabel() -> UILabel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let currentDate = dateFormatter.string(from: Date())
        
        let dateLabel = UILabel()
        dateLabel.text = currentDate.capitalized
        
        return dateLabel
    }
    
    // MARK: - Actions
    
    @objc
    func didTapHeaderView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        
        output.didTapHeaderView(number: view.tag)
    }
    
    @objc
    func didTapCollapseButton(_ button: UIButton) {
        var indexPaths = [IndexPath]()
        
        let section = button.tag
        let exercises = output.getExercises(at: section)
        for exerciseIndex in 0..<exercises.count {
            let indexPath = IndexPath(row: exerciseIndex, section: section)
            indexPaths.append(indexPath)
        }
        
        if output.toggleCollapsed(at: section) {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}

// MARK: - UITableViewDataSource

extension NotepadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotepadTableViewCell.reuseID, for: indexPath) as? NotepadTableViewCell else {
            return UITableViewCell()
        }
        
        let exercise = output.getExercise(at: indexPath.section, at: indexPath.row)
        cell.configure(with: exercise)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotepadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NotepadSectionHeaderView()
        
        let workoutDay = output.getWorkoutDay(section)
        let headerViewState = output.headerViewState()
        headerView.configure(with: workoutDay, and: section, state: headerViewState)
        headerView.addActions(self, viewAction: #selector(didTapHeaderView), buttonAction: #selector(didTapCollapseButton))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: - NotepadViewInput

extension NotepadViewController: NotepadViewInput {
    func configure(with viewModel: NotepadViewModel) {
        stateLabel.attributedText = viewModel.stateTitle
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
