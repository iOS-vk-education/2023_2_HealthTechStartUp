//
//  ProfileViewController.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: ProfileViewOutput
    private let userImageView = UIImageView()
    private let changeUserImageButton = UIButton()
    private let scrollView = UIScrollView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let navBarTitle = UILabel()

    init(output: ProfileViewOutput) {
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
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapWholeView))
                gestureRecognizer.cancelsTouchesInView = false
                view.addGestureRecognizer(gestureRecognizer)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        self.view.addGestureRecognizer(swipeRight)
        
        navBarTitle.attributedText = ProfileViewModel().profileTitle
        self.navigationItem.titleView = navBarTitle
        navigationController?.navigationBar.tintColor = Constants.accentColor
        
        view.addSubviews(scrollView)
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

extension ProfileViewController: ProfileViewInput {
    func configure(with: ProfileViewModel, and userImage: UIImage) {
        userImageView.image = userImage
    }
    
    func showAlert(with key: String, message: String) {
        switch key {
        case "logout":
            let error = NSError(domain: "Everydaytech.ru", code: 400)
            AlertManager.showLogoutError(on: self, with: error)
        case "getUsernameError": AlertManager.showUnknownFetchingUserError(on: self)
        case "image": 
            let error = NSError(domain: "Everydaytech.ru", code: 400)
            AlertManager.showFetchingUserError(on: self, with: error)
        default:
            let error = NSError(domain: "Everydaytech.ru", code: 400)
            AlertManager.showLogoutError(on: self, with: error)
        }
    }
}

private extension ProfileViewController {
    // MARK: - Setup
    
    func setup() {
        setupScrollView()
        setupTableView()
        setupImage()
        setupButton()
    }
    
    func setupScrollView() {
        scrollView.addSubviews(userImageView, changeUserImageButton, tableView)
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .none
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: .zero,
                                                left: .zero,
                                                bottom: .zero,
                                                right: .zero)
        tableView.separatorColor = .black
    }
    
    func setupImage() {
        
        userImageView.layer.cornerRadius = UIScreen.main.bounds.size.width * 0.5 / 2
        userImageView.clipsToBounds = true
    }
    
    func setupButton() {
        changeUserImageButton.setAttributedTitle(ProfileViewModel().selectImageTitle, for: .normal)
        changeUserImageButton.setAttributedTitle(ProfileViewModel().selectImageTitle, for: .normal)
    }
    
    func layout() {
        
        scrollView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom(view.pin.safeArea)
        
        userImageView.pin
            .top(to: scrollView.edge.top)
            .hCenter()
            .size(Constants.ImageView.size)
        
        changeUserImageButton.pin
            .top(to: userImageView.edge.bottom)
            .horizontally()
            .height(Constants.Button.height)
        
        tableView.pin
            .horizontally()
            .top(to: changeUserImageButton.edge.bottom)
            .bottom(to: scrollView.edge.bottom)
    }
    
    // MARK: Actions
    
    @objc
    private func editingUserNameDidEnd(username: String) {
        print(username)
        output.updateUserName(username: username)
    }
    
    @objc
    private func didTapWholeView() {
        view.endEditing(true)
    }
    
    @objc
    func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            output.getBack()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.TableView.numberOfSectionsInTableView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return Constants.TableView.numberOfRowsInFirstSectionInTableView
        case 1: return Constants.TableView.numberOfRowsInSecondSectionInTableView
        case 2: return Constants.TableView.numberOfRowsInThirdSectionInTableView
        case 3: return Constants.TableView.numberOfRowsInFourthSectionInTableView
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == [0, 0] {
            let reuseID = ProfileTableViewCellWithTextField.reuseID
            tableView.register(ProfileTableViewCellWithTextField.self, forCellReuseIdentifier: reuseID)
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ProfileTableViewCellWithTextField {
                cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
                
                cell.textField.delegate = self
                output.getUsername { username in
                    if let username = username {
                        cell.configure(with: NSAttributedString(string: username, attributes: Constants.Styles.titleAttributes))
                    } else {
                        print("error")
                    }
                }
                return cell
            }
        } else {
            let reuseID = ProfileTableViewCellWithTitle.reuseID
            tableView.register(ProfileTableViewCellWithTitle.self, forCellReuseIdentifier: reuseID)
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ProfileTableViewCellWithTitle {
                
                cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
                if indexPath.section == 1 {
                    let model = ProfileViewModel().buttonInSecondSectionTitles
                    cell.configure(with: model[indexPath.row])
                }
                
                if indexPath.section == 2 {
                    cell.configure(with: ProfileViewModel().exitTitle)
                }
                
                if indexPath.section == 3 {
                    cell.configure(with: ProfileViewModel().deleteAccount)
                }
                
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: output.didTapChangeEmailCell()
            case 1: output.didTapChangePasswordCell()
            default: return
            }
        }
        
        if indexPath.section == 2 {
            output.didTapLogoutButton()
        }
        if indexPath.section == 3 {
            output.didTapDeleteAccountCell()
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let username = textField.text ?? ""
        editingUserNameDidEnd(username: username)
    }
}
// MARK: - Constants

private extension ProfileViewController {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.grayElement
        static let gray: UIColor = .gray
        
        struct Styles {
            static let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.Text.primary,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        }
        struct TableView {
            static let numberOfSectionsInTableView: Int = 4
            static let numberOfRowsInFirstSectionInTableView = 1
            static let numberOfRowsInSecondSectionInTableView = 2
            static let numberOfRowsInThirdSectionInTableView = 1
            static let numberOfRowsInFourthSectionInTableView = 1
            static let colorOpacity: CGFloat = 0.1
            static let marginTop: CGFloat = 10
            static let matginBottom: CGFloat = 50
        }
        
        struct ImageView {
            static let size: CGFloat = 200
        }
        
        struct Button {
            static let height: CGFloat = 20
        }
    }
}
