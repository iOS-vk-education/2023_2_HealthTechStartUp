//
//  SettingsTableViewManager.swift
//  Everyday
//
//  Created by Михаил on 20.04.2024.
//

import Foundation
import UIKit

final class SettingsTableViewManager: NSObject {
    private weak var tableView: UITableView?
    private let model = SettingsViewModel()
    private weak var sectionSelector: TableViewDelegateSelection?
    
    init(tableView: UITableView, sectionSelector: TableViewDelegateSelection) {
        self.tableView = tableView
        self.sectionSelector = sectionSelector
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reload() {
        tableView?.reloadData()
    }
        
    // MARK: - Actions
    
    @objc
    func switchValueChanged(_ sender: UISwitch) {
        let settingsUserDefaultService = SettingsUserDefaultsService.shared
        guard let cell = sender.superview as? UITableViewCell,
              let indexPath = tableView?.indexPath(for: cell) else {
            return
        }
        settingsUserDefaultService.saveSwitchValue(switchState: sender.isOn, key: indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension SettingsTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

// MARK: - Default Delegate

extension SettingsTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        sectionSelector?.didSelectRowAt(indexPath)
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

// MARK: - TableView sections

private extension SettingsTableViewManager {
    func configureGeneralSectionCell(for indexPath: IndexPath, with model: SettingsViewModel) -> UITableViewCell {
        guard let cell = tableView?.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = model.generalSettingsSectionCellModel[indexPath.row]
        cell.configure(with: viewModel)
        cell.setBackgroundColor(indexPath: indexPath, cell: Constants.CellType.general)
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
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
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
        cell.accessoryType = .none
        return cell
    }

    func configureCell(for indexPath: IndexPath, with viewModel: SettingsTableViewCellModel, cellType: String) -> SettingsTableViewCell {
        guard let cell = tableView?.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as? SettingsTableViewCell else {
            return SettingsTableViewCell()
        }
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
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

private extension SettingsTableViewManager {
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
