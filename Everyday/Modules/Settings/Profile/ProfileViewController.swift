//
//  ProfileViewController.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit
import PhotosUI
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
    func configure(with model: ProfileViewModel) {
        navBarTitle.attributedText = model.profileTitle
        changeUserImageButton.setAttributedTitle(model.selectImageTitle, for: .normal)
    }
    
    func setupProfileImage(image: UIImage) {
        userImageView.image = image
    }
    
//    func configure(with: ProfileViewModel, and userImage: UIImage) {
//        userImageView.image = userImage
//  }
    
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
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.cornerRadius = UIScreen.main.bounds.size.width * 0.5 / 2
        userImageView.clipsToBounds = true
    }
    
    func setupButton() {
        changeUserImageButton.addTarget(self, action: #selector(didTapChangeUserImageButton), for: .touchUpInside)
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
    private func didTapChangeUserImageButton() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
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
        let whichSing = output.getWhichSing()
        switch whichSing {
        case "vk", "google":
            let model = output.getProfileViewModelSingWithVKOrGoogle()
            return model.sectionsModels.count
        case "email":
            let model = output.getProfileViewModelSingWithEmail()
            return model.sectionsModels.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let whichSing = output.getWhichSing()
        switch whichSing {
        case "vk", "google":
            let model = output.getProfileViewModelSingWithVKOrGoogle()
            return model.sectionsModels[section].count
        case "email":
            let model = output.getProfileViewModelSingWithEmail()
            return model.sectionsModels[section].count
        default: return 5
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
                let whichSing = output.getWhichSing()
                
                cell.backgroundColor = Constants.gray.withAlphaComponent(Constants.TableView.colorOpacity)
                if indexPath.section == 1 {
                    switch whichSing {
                    case "vk", "google":
                        let model = output.getProfileViewModelSingWithVKOrGoogle()
                        cell.configure(with: model.sectionsModels[indexPath.section][indexPath.row])
                    case "email":
                        let model = output.getProfileViewModelSingWithEmail()
                        cell.configure(with: model.sectionsModels[indexPath.section][indexPath.row])
                    default: cell.configure(with: NSAttributedString(string: ""))
                    }
                }
                
                if indexPath.section == 2 {
                    switch whichSing {
                    case "vk", "google":
                        let model = output.getProfileViewModelSingWithVKOrGoogle()
                        cell.configure(with: model.sectionsModels[indexPath.section][indexPath.row])
                    case "email":
                        let model = output.getProfileViewModelSingWithEmail()
                        cell.configure(with: model.sectionsModels[indexPath.section][indexPath.row])
                    default: cell.configure(with: NSAttributedString(string: ""))
                    }
                }
                
                if indexPath.section == 3 {
                    switch whichSing {
                    case "email":
                        let model = output.getProfileViewModelSingWithEmail()
                        cell.configure(with: model.sectionsModels[indexPath.section][indexPath.row])
                    default: cell.configure(with: NSAttributedString(string: ""))
                    }
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
        switch output.getWhichSing() {
        case "vk", "google":
            if indexPath.section == 1 {
                output.didTapLogoutButton()
            }
            if indexPath.section == 2 {
                output.didTapDeleteAccountCell()
            }
        case "email":
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
        default:
            print("чтото не то")
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let username = textField.text ?? ""
        editingUserNameDidEnd(username: username)
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        for result in results where result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.userImageView.image = image
                        self.output.didTapChangeUserImageButton(image: image, error: nil)
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.output.didTapChangeUserImageButton(image: nil, error: error)
                    }
                }
            }
        }
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
