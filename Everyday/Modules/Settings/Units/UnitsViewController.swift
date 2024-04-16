//
//  UnitsViewController.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit
import PinLayout

final class UnitsViewController: UIViewController {
    private let output: UnitsViewOutput
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let navBarTitle = UILabel()
    
    // MARK: - lifecycle
    
    init(output: UnitsViewOutput) {
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
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        self.view.addGestureRecognizer(swipeRightGestureRecognizer)
        
        self.navigationItem.titleView = navBarTitle
        navigationController?.navigationBar.tintColor = Constants.accentColor
        
        navigationController?.navigationBar.isHidden = false
        
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        layout()
    }
}

// MARK: - Setup

private extension UnitsViewController {
    
    func setup() {
        setupTableView()
        view.addSubviews(tableView)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UnitsTableViewCell.self, forCellReuseIdentifier: UnitsTableViewCell.reuseID)
        
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

extension UnitsViewController: UnitsViewInput {
    func configure(with model: UnitsViewModel) {
        navBarTitle.attributedText = model.unitsTitle
    }
    
    func showAlert(with key: String, message: String) {
    }
}

// MARK: - UITableViewDataSource

extension UnitsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.TableView.numberOfSectionsInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = output.getUnitsViewModel()
        switch section {
        case 0: return model.weightSectionModel.count
        case 1: return model.measurementsSectionModel.count
        case 2: return model.weightSectionModel.count
        case 3: return model.distanceSectionModel.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UnitsTableViewCell.reuseID, for: indexPath) as? UnitsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
        
        let model = output.getUnitsViewModel()
        let settingsUserDefaultService = SettingsUserDefaultsService.shared
        
        if indexPath.section == 0 {
            if indexPath == settingsUserDefaultService.getSelectedBodyWeightCellIndexPath() {
                let accessoryView = UIImageView(image: model.accessoryCellImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                cell.accessoryView = nil
            }
            let viewModel = model.weightSectionModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 1 {
            if indexPath == output.getSelectedMeasurementsCellIndexPath() {
                let accessoryView = UIImageView(image: model.accessoryCellImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                cell.accessoryView = nil
            }
            let viewModel = model.measurementsSectionModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 2 {
            if indexPath == output.getSelectedLoadWeightCellIndexPath() {
                let accessoryView = UIImageView(image: model.accessoryCellImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                cell.accessoryView = nil
            }
            let viewModel = model.weightSectionModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 3 {
            if indexPath == output.getSelectedDistanceCellIndexPath() {
                let accessoryView = UIImageView(image: model.accessoryCellImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                cell.accessoryView = nil
            }
            let viewModel = model.distanceSectionModel
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension UnitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0: output.didTapOnCellInBodyWeigthSection(row: indexPath.row)
        case 1: output.didTapOnCellInMeasurementsSection(row: indexPath.row)
        case 2: output.didTapOnCellInLoadWeigthSection(row: indexPath.row)
        case 3: output.didTapOnCellInDistanceSection(row: indexPath.row)
        default:
            print("Error when tap on tableView")
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = output.getUnitsViewModel()
        let headerView = UILabel()
        if section == 0 {
            headerView.attributedText = model.bodyWeigthTitle
            return headerView
        }
        
        if section == 1 {
            headerView.attributedText = model.measurementsTitle
            return headerView
        }
        
        if section == 2 {
            headerView.attributedText = model.weightTitle
            return headerView
        }
        
        if section == 3 {
            headerView.attributedText = model.distanceTitle
            return headerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.marginTop
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UILabel()
        footerView.attributedText = output.getUnitsViewModel().aboutUnitsTitle
        footerView.textAlignment = .center
        footerView.numberOfLines = .max
        
        if section == 3 {
            return footerView
        } else {
            return UILabel()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return Constants.TableView.heightForFooterView
        } else {
            return Constants.TableView.matginBottom
        }
    }
}

// MARK: - Constants

private extension UnitsViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        static let buttonColor: UIColor = UIColor.UI.accent
        
        struct TableView {
            static let numberOfSectionsInTableView: Int = 4
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 35
            static let matginBottom: CGFloat = 50
            static let heightForFooterView: CGFloat = 100
        }
    }
}
