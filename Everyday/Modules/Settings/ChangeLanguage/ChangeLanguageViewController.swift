//
//  ChangeLanguageViewController.swift
//  Everyday
//
//  Created by Yaz on 05.05.2024.
//
//

import UIKit
import PinLayout

final class ChangeLanguageViewController: UIViewController {
    private let output: ChangeLanguageViewOutput
    
    private let navBarTitle = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    init(output: ChangeLanguageViewOutput) {
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
        print(output.getCurrentLanguageIndexPath())
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

// MARK: - Setup

private extension ChangeLanguageViewController {
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

extension ChangeLanguageViewController: ChangeLanguageViewInput {
    func configure(with model: ChangeLanguageViewModel) {
        navBarTitle.attributedText = model.changeLanguageTitle
    }
}

// MARK: - UITableViewDataSource

extension ChangeLanguageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = output.getChangeLanguageViewModel()
        return model.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ChangeLanguageTableViewCell.self, forCellReuseIdentifier: ChangeLanguageTableViewCell.reuseID)
        let reuseID = ChangeLanguageTableViewCell.reuseID
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ChangeLanguageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
        let model = output.getChangeLanguageViewModel()
        
        if indexPath == output.getCurrentLanguageIndexPath() {
            let accessoryView = UIImageView(image: model.accessoryCellImage)
            accessoryView.tintColor = Constants.accentColor
            cell.accessoryView = accessoryView
        } else {
            cell.accessoryView = nil
        }
        
        cell.configure(with: model.languages[indexPath.row])
        return cell
    }
}

extension ChangeLanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            output.didTapEnCell()
        case 1:
            output.didTapRuCell()
        default:
            return
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let model = output.getChangeLanguageViewModel()
        
        return model.interfaceLanguageHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let model = output.getChangeLanguageViewModel()
        
        return model.descriptionOfChanges
    }
}

// MARK: - Constants

private extension ChangeLanguageViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.primary
        static let gray: UIColor = .gray
        static let buttonColor: UIColor = UIColor.UI.accent
        
        struct TableView {
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 35
            static let matginBottom: CGFloat = 50
            static let heightForFooterView: CGFloat = 100
        }
    }
}
