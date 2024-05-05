//
//  ThemeViewController.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import UIKit
import PinLayout

final class ThemeViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: ThemeViewOutput
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let navBarTitle = UILabel()

    // MARK: - lifecycle
    
    init(output: ThemeViewOutput) {
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
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = Constants.accentColor
        
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        layout()
    }
}

private extension ThemeViewController {
    
    func setup() {
        setupTableView()
        view.addSubviews(tableView)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ThemeTableViewCell.self, forCellReuseIdentifier: ThemeTableViewCell.reuseID)
        
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
extension ThemeViewController: ThemeViewInput {
    func configure(with model: ThemeViewModel) {
        navBarTitle.attributedText = model.themeTitle
    }
}

extension ThemeViewController: UITableViewDataSource {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThemeTableViewCell.reuseID, for: indexPath) as? ThemeTableViewCell else {
                    return UITableViewCell()
                }
        
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
        let model = output.getThemeViewModel()
        
        if indexPath == output.getSelectedThemeCellIndexPath() {
            let accessoryView = UIImageView(image: model.accessoryCellImage)
            accessoryView.tintColor = Constants.accentColor
            cell.accessoryView = accessoryView
        } else {
            cell.accessoryView = nil
        }
        
        if indexPath.section == 0 {
            let cellTitle = model.autoThemeTitle
            cell.configure(with: cellTitle)
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cellTitles = model.darkOrLightSectionSellModel
            cell.configure(with: cellTitles[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ThemeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            output.didTapOnAutoThemeCell()
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: output.didTapOnDarkThemeCell()
            case 1: output.didTapOnLightThemeCell()
            default: output.didTapOnAutoThemeCell()
            }
        }

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let model = output.getThemeViewModel()
        let explanationAutoTheme = UILabel()
        explanationAutoTheme.attributedText = model.explanationForAutoTheme
        explanationAutoTheme.textAlignment = .center
        explanationAutoTheme.numberOfLines = .max
        
        if section == 0 {
            return explanationAutoTheme
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.marginTop
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Constants.TableView.matginBottom
    }
}

// MARK: - Constants

private extension ThemeViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        static let buttonColor: UIColor = UIColor.UI.accent
        
        struct TableView {
            static let numberOfSectionsInTableView: Int = 2
            static let rowsInFirstSectionInTableView: Int = 1
            static let rowsInSecondSectionInTableView: Int = 2
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 35
            static let matginBottom: CGFloat = 100
        }
    }
}
