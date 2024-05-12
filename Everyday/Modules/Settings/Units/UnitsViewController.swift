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
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc))
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
    
    private func setup() {
        setupTableView()
        view.addSubviews(tableView)
    }
    
    private func setupTableView() {
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
    
    private func layout() {
        tableView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
    }
    
    // MARK: - Actions
    
    @objc
    private func swipeFunc(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            output.didSwipe()
        }
    }
}

extension UnitsViewController: UnitsViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
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
        case Constants.Sections.bodyWeight: return model.weightSectionModel.count
        case Constants.Sections.measurements: return model.measurementsSectionModel.count
        case Constants.Sections.loadWeight: return model.weightSectionModel.count
        case Constants.Sections.distance: return model.distanceSectionModel.count
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

        if indexPath.section == Constants.Sections.bodyWeight {
            if indexPath == output.getSelectedBodyWeightCellIndexPath() {
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
        
        if indexPath.section == Constants.Sections.measurements {
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
        
        if indexPath.section == Constants.Sections.loadWeight {
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
        
        if indexPath.section == Constants.Sections.distance {
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
        case 0: output.didTapOnCellInBodyWeigthSection(indexPath: indexPath)
        case 1: output.didTapOnCellInMeasurementsSection(indexPath: indexPath)
        case 2: output.didTapOnCellInLoadWeigthSection(indexPath: indexPath)
        case 3: output.didTapOnCellInDistanceSection(indexPath: indexPath)
        default:
            print("Error when tap on tableView")
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = output.getUnitsViewModel()
        let headerView = UILabel()
        if section == Constants.Sections.bodyWeight {
            headerView.attributedText = model.bodyWeigthTitle
            return headerView
        }
        
        if section == Constants.Sections.measurements {
            headerView.attributedText = model.measurementsTitle
            return headerView
        }
        
        if section == Constants.Sections.loadWeight {
            headerView.attributedText = model.weightTitle
            return headerView
        }
        
        if section == Constants.Sections.distance {
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
        
        if section == Constants.Sections.distance {
            return footerView
        } else {
            return UILabel()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == Constants.Sections.distance {
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
        
        struct Sections {
            static let bodyWeight: Int = 0
            static let measurements: Int = 1
            static let loadWeight: Int = 2
            static let distance: Int = 3
        }
    }
}
