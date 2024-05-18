//
//  HealthViewController.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//  
//

import UIKit
import PinLayout

final class HealthViewController: UIViewController {
    private let output: HealthViewOutput
    
    private let healthService = HealthService()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let navBarTitle = UILabel()

    init(output: HealthViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.didLoadView()
        
        view.backgroundColor = Constants.backgroundColor
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc))
        self.view.addGestureRecognizer(swipeRightGestureRecognizer)
        
        self.navigationItem.titleView = navBarTitle
        navigationController?.navigationBar.tintColor = Constants.accentColor
        
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Setup

private extension HealthViewController {
    func setup() {
        setupTableView()
        view.addSubviews(tableView)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero,
                                                left: .zero,
                                                bottom: .zero,
                                                right: .zero)
        tableView.separatorColor = .black
    }
    
    // MARK: - Layout
    
    func layout() {
        
        tableView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
    }
    
    // MARK: - Actions
    
    @objc
    func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            output.didSwipe()
        }
    }
}

extension HealthViewController: HealthViewInput {
    func configure(with model: HealthViewModel) {
        navBarTitle.attributedText = model.healthTitle
    }
}

// MARK: - UITableViewDataSource

extension HealthViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.TableView.numberOfSectionInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return Constants.TableView.numberOfRowsInFirstSection
        case 1: return Constants.TableView.numberOfRowsInSecondSection
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getHealthViewModel()
        if indexPath.section == 0 {
            tableView.register(HealthTableViewCellHealthCondition.self, forCellReuseIdentifier: HealthTableViewCellHealthCondition.reuseID)
            let reuseID = HealthTableViewCellHealthCondition.reuseID
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? HealthTableViewCellHealthCondition else {
               return UITableViewCell()
            }
            if output.healthKitIsAvaible() {
                let accessoryView = UIImageView(image: model.connectedImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                let accessoryView = UIImageView(image: model.notConnectedImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            }
            cell.configure(with: model.connectedTitle)
            return cell
        }
        
        if indexPath.section == 1 {
            tableView.register(HealthTableViewCellButton.self, forCellReuseIdentifier: HealthTableViewCellButton.reuseID)
            let reuseID = HealthTableViewCellButton.reuseID
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? HealthTableViewCellButton else {
               return UITableViewCell()
            }
            
            cell.configure(with: model.cellsTitlesInSecondSection[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}

extension HealthViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let model = output.getHealthViewModel()
        let footerView = UILabel()
        if section == 0 {
            footerView.attributedText = model.discriptionForConnectedTitle
            footerView.numberOfLines = .max
            return footerView
        }
  
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.heightForFooterView
    }
}

// MARK: - Constants

private extension HealthViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        static let buttonColor: UIColor = UIColor.UI.accent
        
        struct TableView {
            static let numberOfRowsInFirstSection: Int = 1
            static let numberOfRowsInSecondSection: Int = 2
            static let numberOfSectionInTableView: Int = 2
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 35
            static let matginBottom: CGFloat = 50
            static let heightForFooterView: CGFloat = 100
        }
    }
}
