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
        print(CoreDataService.shared.getAllItems())
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

private extension SettingsViewController {
    
    // MARK: - Setup
    
    func setup() {
        setupTableView()
        view.addSubviews(tableView)
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseID)
        
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
    func switchValueChanged(_ sender: UISwitch) {
        let settingsUserDefaultService = SettingsUserDefaultsService.shared
        guard let cell = sender.superview as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        settingsUserDefaultService.saveSwitchValue(switchState: sender.isOn, key: indexPath.row)
    }
}

extension SettingsViewController: SettingsViewInput {
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.TableView.numberOfSectionsInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = output.getViewModel()
        switch section {
        case 0: return model.generalSettingsSectionCellModel.count
        case 1: return model.profileSettingsSectionCellModel.count
        case 2: return model.aboutAppSettingsSectionCellModel.count
        case 3: return model.tellFriendsSectionCellModel.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as? SettingsTableViewCell else {
                    return UITableViewCell()
                }
        cell.selectionStyle = .blue
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
        let model = output.getViewModel()
        let settingsUserDefaultService = SettingsUserDefaultsService.shared
        
        if indexPath.section == 0 && indexPath.row <= 1 {
            let viewModel = model.generalSettingsSectionCellModel
            cell.configure(with: viewModel[indexPath.row])
            
            let switchControl = UISwitch()
            switchControl.isOn = settingsUserDefaultService.switchIsOn(key: indexPath.row)
            switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            
            cell.accessoryView = switchControl
            cell.selectionStyle = .none
            
            return cell
        }
        
        if indexPath.section == 0 {
            let viewModel = model.generalSettingsSectionCellModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 1 {
            let viewModel = model.profileSettingsSectionCellModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 2 {
            let viewModel = model.aboutAppSettingsSectionCellModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 3 {
            let viewModel = model.tellFriendsSectionCellModel
            cell.configure(with: viewModel[indexPath.row])
            cell.accessoryType = .none
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = output.getViewModel()
        if section == 3 {
            return model.supportEverydayTitle
        }
        
        return String()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return Constants.TableView.matginBottom
        }
        
        return 0
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 2: output.didTapThemeCell()
            case 3: output.didTapDateAndTimeCell()
            case 4: output.didTapUnitsCell()
            default: print("ERROR")
            }
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: output.didTapProfileCell()
            default: print("ERROR")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 3 {
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
        
        if section == 3 {
            return tableViewFooterLabel
        } else {
            return UIView()
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
            static let numberOfSectionsInTableView: Int = 4
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 10
            static let matginBottom: CGFloat = 50
        }
    }
}
