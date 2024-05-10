//
//  ExtraViewController.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit
import PinLayout

final class ExtraViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: ExtraViewOutput
    
    private let tableView = UITableView()
    private let finishButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init

    init(output: ExtraViewOutput) {
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

private extension ExtraViewController {
    
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
        tableView.register(ExtraTableViewCell.self, forCellReuseIdentifier: ExtraTableViewCell.reuseID)
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

// MARK: - TableViewDataSource

extension ExtraViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExtraTableViewCell.reuseID, for: indexPath) as? ExtraTableViewCell else {
            return UITableViewCell()
        }
        
        let viewType = output.getViewType(at: indexPath.row)
        let viewModel = ExtraTableViewCellViewModel(viewType: viewType)
        let isDone = output.getSwitchState(at: indexPath.row)
        
        cell.configure(with: viewModel, and: indexPath.row, isDone: isDone)
        
        return cell
    }
}

// MARK: - TableViewDelegate

extension ExtraViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRowAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ViewInput

extension ExtraViewController: ExtraViewInput {
    func configure(with viewModel: ExtraViewModel) {
        finishButton.setAttributedTitle(viewModel.finishTitle, for: .normal)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoadingView() {
        view.addSubview(activityIndicator)
        
        activityIndicator.pin
            .hCenter()
            .vCenter()
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        activityIndicator.removeFromSuperview()
    }
}

// MARK: - Constants

private extension ExtraViewController {
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
