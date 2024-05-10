//
//  SettingsViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import UIKit
import PinLayout

final class SettingsViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: SettingsViewOutput
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let navBarTitle = UILabel()
    private lazy var tableViewManager = SettingsTableViewManager(tableView: tableView, sectionSelector: self)
    
    // MARK: - lifecycle
    
    init(output: SettingsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        navigationController?.navigationBar.isHidden = false
        
        setup()
        tableViewManager.reload()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupTableView()
        view.addSubview(tableView)
    }
    
    func setupTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseID)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        tableView.separatorColor = .black
    }
    
    // MARK: - Layout
    
    private func layout() {
        tableView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
    }
}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {
}

// MARK: - TableViewDelegateSelection

extension SettingsViewController: TableViewDelegateSelection {
    func didSelectRowAt(_ indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 2:
                output.didTapThemeCell()
            case 3:
                output.didTapDateAndTimeCell()
            case 4:
                output.didTapUnitsCell()
            default:
                return
            }
        case 1:
            output.didTapProfileCell()
        case 2:
            output.didTapHealthCell()
        case 3:
            switch indexPath.row {
            case 0:
                output.didTapProblemCell()
            case 1:
                output.didTapSuggestCell()
            case 2:
                output.didTapPrivacyCell()
            default:
               return
            }
        case 4:
            output.didTapTellFriendsCell()
        default:
            return
        }
    }
}

// MARK: - Constants

private extension SettingsViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        
        struct TableView {
            static let numberOfSectionsInTableView: Int = 5
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 10
            static let matginBottom: CGFloat = 50
        }
    }
}
