//
//  DateAndTimeInteractor.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation
import UIKit

final class DateAndTimeViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: DateAndTimeViewOutput
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let navBarTitle = UILabel()

    // MARK: - lifecycle
    
    init(output: DateAndTimeViewOutput) {
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

private extension DateAndTimeViewController {
    
    func setup() {
        setupTableView()
        view.addSubviews(tableView)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DateAndTimeTableViewCell.self, forCellReuseIdentifier: DateAndTimeTableViewCell.reuseID)
        
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
extension DateAndTimeViewController: DateAndTimeViewInput {
    func configure(with model: DateAndTimeViewModel) {
        navBarTitle.attributedText = model.dateAndTimeTitle
    }
}

extension DateAndTimeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.TableView.numberOfSectionsInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return Constants.TableView.rowsInFirstSectionInTableView
        case 1: return Constants.TableView.rowsInSecondSectionInTableView
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseID = DateAndTimeTableViewCell.reuseID
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? DateAndTimeTableViewCell else {
                    return UITableViewCell()
                }
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
        let model = output.getDateAndTimeViewModel()
        if indexPath.section == 0 {
            if indexPath == output.getSelectedBegginingOfTheWeekCellIndexPath() {
                let accessoryView = UIImageView(image: model.accessoryCellImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                cell.accessoryView = nil
            }
            let cellTitles = model.weekStartsSectionModel
            cell.configure(with: cellTitles[indexPath.row])
            
            return cell
        }
        
        if indexPath.section == 1 {
            if indexPath == output.getSelectedTimeFormatCellIndexPath() {
                let accessoryView = UIImageView(image: model.accessoryCellImage)
                accessoryView.tintColor = Constants.accentColor
                cell.accessoryView = accessoryView
            } else {
                cell.accessoryView = nil
            }
            let cellTitles = model.hoursFormatSectionModel
            cell.configure(with: cellTitles[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension DateAndTimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsUserDefaultService = SettingsUserDefaultsService.shared
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            output.didTapOnCellInBegginingOfTheWeekSection(indexPath: indexPath)
        }
        
        if indexPath.section == 1 {
            output.didTapOnCellInTimeFormatSection(indexPath: indexPath)
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = output.getDateAndTimeViewModel()
        let headerView = UILabel()
        if section == 0 {
            headerView.attributedText = model.weekStartsTitle
            return headerView
        } else {
            headerView.attributedText = model.hoursFormatTitle
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.marginTop
    }
}

// MARK: - Constants

private extension DateAndTimeViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        static let buttonColor: UIColor = UIColor.UI.accent
        
        struct TableView {
            static let numberOfSectionsInTableView: Int = 2
            static let rowsInFirstSectionInTableView: Int = 2
            static let rowsInSecondSectionInTableView: Int = 2
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 35
            static let matginBottom: CGFloat = 50
        }
    }
}
