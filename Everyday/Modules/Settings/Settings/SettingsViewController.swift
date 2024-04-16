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
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }

    // MARK: - Setup
    
    func setup() {
        setupTableView()
        view.addSubview(tableView)
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseID)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
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
    func switchValueChanged(_ sender: UISwitch) {
        let settingsUserDefaultService = SettingsUserDefaultsService.shared
        guard let cell = sender.superview as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        settingsUserDefaultService.saveSwitchValue(switchState: sender.isOn, key: indexPath.row)
    }
}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = output.getViewModel()
        
        switch indexPath.section {
        case 0:
            return configureGeneralSectionCell(for: indexPath, with: model)
        case 1:
            return configureProfileSectionCell(for: indexPath, with: model)
        case 2:
            return configureHealthSectionCell(for: indexPath, with: model)
        case 3:
            return configureAboutAppSectionCell(for: indexPath, with: model)
        case 4:
            return configureTellFriendsSectionCell(for: indexPath, with: model)
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.TableView.numberOfSectionsInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = output.getViewModel()
        
        switch section {
        case 0: 
            return model.generalSettingsSectionCellModel.count
        case 1, 2, 4:
            return 1
        case 3:
            return model.aboutAppSettingsSectionCellModel.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = output.getViewModel()
        if section == Constants.headerSection {
            return model.supportEverydayTitle
        }
        
        return String()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == Constants.headerSection {
            return Constants.TableView.matginBottom
        }
        
        return 0
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
               fatalError("ambigious row in tableView !")
            }
        case 1:
            output.didTapProfileCell()
        case 2:
            output.didTapHealthCell()
        default:
            fatalError("no appropriate section in tableView !")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 4 {
            guard let header = view as? UITableViewHeaderFooterView else {
                return
            }
            header.textLabel?.textColor = Constants.textColor
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let model = output.getViewModel()
        let tableViewFooterLabel = UILabel()
        tableViewFooterLabel.attributedText = model.tyTitle
        tableViewFooterLabel.textAlignment = .center
        
        if section == Constants.headerSection {
            return tableViewFooterLabel
        } else {
            return UIView()
        }
    }
}

private extension SettingsViewController {
    func configureGeneralSectionCell(for indexPath: IndexPath, with model: SettingsViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = model.generalSettingsSectionCellModel[indexPath.row]
        cell.configure(with: viewModel)
        cell.setBackgroundColor(indexPath: indexPath, cell: Constants.CellType.general)
        
        if indexPath.row <= 1 {
            configureSwitchForCell(cell, at: indexPath)
        }

        return cell
    }

    func configureProfileSectionCell(for indexPath: IndexPath, with model: SettingsViewModel) -> SettingsTableViewCell {
        let viewModel = model.profileSettingsSectionCellModel
        return configureCell(for: indexPath, with: viewModel, cellType: Constants.CellType.profile)
    }

    func configureHealthSectionCell(for indexPath: IndexPath, with model: SettingsViewModel) -> SettingsTableViewCell {
        let viewModel = model.healthSettingsSectionCellModel
        return configureCell(for: indexPath, with: viewModel, cellType: Constants.CellType.appleHealth)
    }

    func configureAboutAppSectionCell(for indexPath: IndexPath, with model: SettingsViewModel) -> SettingsTableViewCell {
        let viewModel = model.aboutAppSettingsSectionCellModel[indexPath.row]
        return configureCell(for: indexPath, with: viewModel, cellType: Constants.CellType.aboutApp)
    }

    func configureTellFriendsSectionCell(for indexPath: IndexPath, with model: SettingsViewModel) -> SettingsTableViewCell {
        let viewModel = model.tellFriendsSectionCellModel
        let cell = configureCell(for: indexPath, with: viewModel, cellType: Constants.CellType.support)
        
        cell.accessoryType = .none
        return cell
    }

    func configureCell(for indexPath: IndexPath, with viewModel: SettingsTableViewCellModel, cellType: String) -> SettingsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as? SettingsTableViewCell else {
            return SettingsTableViewCell()
        }
        
        cell.configure(with: viewModel)
        cell.setBackgroundColor(indexPath: indexPath, cell: cellType)
        
        return cell
    }

    func configureSwitchForCell(_ cell: SettingsTableViewCell, at indexPath: IndexPath) {
        let switchControl = UISwitch()
        
        switchControl.isOn = SettingsUserDefaultsService.shared.switchIsOn(key: indexPath.row)
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        cell.accessoryView = switchControl
        cell.selectionStyle = .none
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
        
        struct CellType {
            static let general: String = "General"
            static let profile: String = "Profile"
            static let appleHealth: String = "AppleHealth"
            static let aboutApp: String = "AboutApp"
            static let support: String = "Support"
        }
        
        static let headerSection: Int = 4
    }
}
