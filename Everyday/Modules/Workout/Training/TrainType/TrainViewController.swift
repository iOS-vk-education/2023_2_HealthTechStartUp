//
//  TrainViewController.swift
//  Everyday
//
//  Created by Михаил on 13.05.2024.
//

import UIKit
import PinLayout
import FirebaseAuth

final class TrainViewController: UIViewController {
    
    // MARK: - private properties
    
    private let infoImage = UIImageView()
    private let infoLabel = UILabel()
    private let infoView = UIView()
    
    private let downloadButton = UIButton()
    private let scrollView = UIScrollView()
    
    private let levelLabel = UILabel()
    private let timeLabel = UILabel()
    private let countLabel = UILabel()
    private let separator1 = UIView()
    private let separator2 = UIView()
    
    private let levelDescriptionLabel = UILabel()
    private let timeDescriptionLabel = UILabel()
    private let countDescriptionLabel = UILabel()
    
    private let descriptionTextLabel = UILabel()
    
    private lazy var clayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.CollectionView.flowLayoutMinimumLineSpacing
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: clayout)
        collectionView.backgroundColor = Constants.gray.withAlphaComponent(-Constants.View.opacity)
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: "ExerciseCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let image: UIImage
    private let model: Train
    private var isFavorited: Bool = false
    private var isDownloaded: Bool = false
    
    // MARK: - lifecycle
    
    init(model: Train, image: UIImage) {
        self.model = model
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.background
                
        setup()
        
        view.addSubviews(infoImage, infoLabel, infoView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(didTapCloseButton)
            )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "heart"),
                style: .plain,
                target: self,
                action: #selector(didTapLikeButton)
            )
        
        navigationItem.leftBarButtonItem?.tintColor = Constants.textColor
        navigationItem.rightBarButtonItem?.tintColor = Constants.textColor
        
        checkIfFavorited()
        checkIfDownloaded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupImage()
        setupView()
        setupLabels()
        setupScrollView()
        setupSeparators()
        setupButton()
        
        infoImage.image = image
        descriptionTextLabel.text = model.description
        
        let model = TrainViewModel(infoLabel: model.title, levelLabel: model.level, timeLabel: model.duration, countLabel: model.count)
        
        downloadButton.setTitle(model.buttonTitle, for: .normal)
        levelDescriptionLabel.attributedText = model.levelDescriptionLabel
        timeDescriptionLabel.attributedText = model.timeDescriptionLabel
        countDescriptionLabel.attributedText = model.countDescriptionLabel
        levelLabel.attributedText = model.levelLabel
        infoLabel.attributedText = model.infoLabel
        timeLabel.attributedText = model.timeLabel
        countLabel.attributedText = model.countLabel
    }
    
    private func setupImage() {
        infoImage.contentMode = .scaleToFill
        infoImage.layer.cornerRadius = Constants.ImageView.cornerRadius
        infoImage.clipsToBounds = true
    }
    
    private func setupLabels() {
        infoLabel.numberOfLines = .zero
        infoLabel.textAlignment = .left
        infoLabel.lineBreakMode = .byWordWrapping
        
        for label in [levelLabel, timeLabel, countLabel,
                      levelDescriptionLabel, timeDescriptionLabel, countDescriptionLabel] {
            label.textAlignment = .center
        }
        
        descriptionTextLabel.textColor = Constants.textColor
        descriptionTextLabel.numberOfLines = .zero
    }
    
    private func setupView() {
        infoView.backgroundColor = Constants.gray.withAlphaComponent(Constants.View.opacity)
        infoView.layer.cornerRadius = Constants.View.cornerRadius
        
        infoView.addSubviews(scrollView, downloadButton)
    }
    
    private func setupScrollView() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = Constants.View.cornerRadius

        scrollView.addSubviews(levelLabel, separator1, timeLabel, separator2, countLabel,
                               levelDescriptionLabel, timeDescriptionLabel, countDescriptionLabel,
                               descriptionTextLabel, collectionView)
    }
    
    private func setupSeparators() {
        separator1.backgroundColor = .gray
        separator2.backgroundColor = .gray
    }
    
    private func setupButton() {
        downloadButton.layer.cornerRadius = Constants.Button.cornerRadius
        downloadButton.backgroundColor = Constants.accentColor
        downloadButton.setTitleColor(Constants.textColor, for: .normal)
        downloadButton.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        downloadButton.backgroundColor = Constants.accentColor
    }
    
    private func getAuthView() {
        let authScreen = AuthorizationContainer.assemble(with: .init()).viewController
        let navigationController = UINavigationController(rootViewController: authScreen)
        navigationController.navigationBar.isHidden = true
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .init("small"), resolver: { _ in
                    return UIScreen.main.bounds.height / 3.5
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = false
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        
        present(navigationController, animated: true)
    }
    
    private func checkIfFavorited() {
        guard let user = Auth.auth().currentUser else {
            return
        }

        Fetcher.shared.isFavorited(recordId: model.id, forUser: user.uid) { isFavorited in
            self.isFavorited = isFavorited
            let imageName = isFavorited ? "heart.fill" : "heart"
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
        }
    }
    
    private func checkIfDownloaded() {
        guard let user = Auth.auth().currentUser else {
            return
        }

        Fetcher.shared.isDownloaded(recordId: model.id, forUser: user.uid) { isDownloaded in
            self.isDownloaded = isDownloaded
            self.updateDownloadButtonTitle()
        }
    }
        
    private func updateDownloadButtonTitle() {
        let title = isDownloaded ? "ChangeEmail_ConfirmButton_title".localized : "TrainViewController_add".localized
        downloadButton.setTitle(title, for: .normal)
    }

    // MARK: - Layout
    
    private func layout() {
        infoImage.pin
            .top(view.pin.safeArea.top)
            .hCenter()
            .size(Constants.ImageView.size)
        
        infoLabel.pin
            .below(of: infoImage, aligned: .center)
            .marginTop(Constants.Label.marginTop)
            .size(Constants.Label.size)
            .sizeToFit(.width)
        
        infoView.pin
            .below(of: infoLabel, aligned: .center)
            .marginTop(Constants.View.marginTop)
            .width(view.frame.width)
            .height(view.frame.height / 2 + 32)
        
        scrollView.pin
            .top()
            .width(infoView.frame.width)
            .height(infoView.frame.height - 80)
        
    let x = (infoView.frame.width - Constants.Label.descriptionSize.width * 3 - 2) / 6
    let spacing = (x * 100).rounded() / 100
        
        levelLabel.pin
            .top(Constants.Label.marginTop)
            .left(Constants.Label.marginHorizontal)
            .size(Constants.Label.descriptionSize)
        
        separator1.pin
            .top(Constants.Separators.marginTop)
            .after(of: levelLabel)
            .marginLeft(Constants.Label.marginHorizontal)
            .height(levelLabel.frame.height * 2)
            .width(Constants.Separators.width)
        
        timeLabel.pin
            .top(Constants.Label.marginTop)
            .after(of: separator1)
            .marginLeft(spacing)
            .height(Constants.Label.descriptionSize.height)
            .width(Constants.Label.descriptionSize.width)
        
        separator2.pin
            .top(Constants.Separators.marginTop)
            .after(of: timeLabel)
            .marginLeft(Constants.Label.marginHorizontal)
            .height(levelLabel.frame.height * 2)
            .width(Constants.Separators.width)
        
        countLabel.pin
            .top(Constants.Label.marginTop)
            .after(of: separator2)
            .marginLeft(spacing)
            .height(Constants.Label.descriptionSize.height)
            .width(Constants.Label.descriptionSize.width)
        
        levelDescriptionLabel.pin
            .below(of: levelLabel, aligned: .center)
            .size(Constants.Label.descriptionSize)
        
        timeDescriptionLabel.pin
            .below(of: timeLabel, aligned: .center)
            .size(Constants.Label.descriptionSize)
        
        countDescriptionLabel.pin
            .below(of: countLabel, aligned: .center)
            .size(Constants.Label.descriptionSize)
        
        descriptionTextLabel.pin
                .below(of: levelDescriptionLabel)
                .marginTop(Constants.Label.descriptionLabelMarginTop)
                .hCenter()
                .width(infoView.frame.width - Constants.Label.marginHorizontal * 2)
                .height(Constants.Label.descriptionLabelHeight)
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let collectionViewHeight = CGFloat(numberOfItems) * 66 + CGFloat(numberOfItems - 1) * Constants.CollectionView.flowLayoutMinimumLineSpacing + 10
            
        collectionView.pin
            .below(of: descriptionTextLabel, aligned: .center)
            .marginTop(Constants.CollectionView.marginTop)
            .width(infoView.frame.width)
            .height(collectionViewHeight)
        
        scrollView.contentSize = CGSize(width: infoView.frame.width, height: collectionView.frame.maxY + 20)
        
        downloadButton.pin
            .below(of: scrollView)
            .hCenter()
            .width(Constants.Button.width)
            .height(Constants.Button.height)
    }
    
    // MARK: - actions
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapLikeButton() {
        guard let user = Auth.auth().currentUser else {
            getAuthView()
            return
        }
        
        isFavorited.toggle()
        HapticService.shared.vibrate(for: .success)
       
        Fetcher.shared.updateFavoriteStatus(with: self.model.id, forUser: user.uid, isFavorited: self.isFavorited)
        let newImageName = isFavorited ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: newImageName)
    }
    
    @objc private func didTapDownloadButton() {
        guard let user = Auth.auth().currentUser else {
            getAuthView()
            return
        }
        
        HapticService.shared.selectionVibrate()
        
        let trainingDaysVC = TrainingDaysViewController(model: self.model, isDownloaded: self.isDownloaded, user: user.uid)
        trainingDaysVC.delegate = self
        
        let navigationController = UINavigationController(rootViewController: trainingDaysVC)
        navigationController.navigationBar.isHidden = true
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .init("small"), resolver: { _ in
                    return self.view.frame.height / 2
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = false
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        
        present(navigationController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension TrainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else {
            return .init()
        }
        
        let text = "TrainViewController_exercise".localized.appending(" \(indexPath.item + 1)")
        cell.titleLabel.text = (text)
        
        let descTitles = model.exercises
        let descTitle = descTitles[indexPath.item]
        
        cell.descriptionLabel.text = descTitle
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TrainViewController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 350, height: 66)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 6, left: 10, bottom: 0, right: 10)
    }
}

extension TrainViewController: ScheduleViewControllerDelegate {
    func scheduleDismiss() {
        checkIfDownloaded()
    }
}

// MARK: - Constants

private extension TrainViewController {
    struct Constants {
        static let background: UIColor = UIColor.background
        static let gray: UIColor = UIColor.gray
        static let textColor: UIColor = UIColor.Text.primary
        static let accentColor: UIColor = UIColor.UI.accent
        
        struct ImageView {
            static let size: CGSize = CGSizeMake(350, 220)
            static let top: CGFloat = -60
            static let cornerRadius: CGFloat = 10
        }
        
        struct Label {
            static let size: CGSize = CGSizeMake(350, 70)
            static let marginTop: CGFloat = 10
            static let descriptionSize: CGSize = CGSizeMake(100, 40)
            static let marginHorizontal: CGFloat = 10
            
            static let descriptionLabelHeight: CGFloat = 130
            static let descriptionLabelMarginTop: CGFloat = 2
        }
        
        struct View {
            static let opacity: CGFloat = 0.1
            static let cornerRadius: CGFloat = 30
            static let marginTop: CGFloat = 10
        }
        
        struct Button {
            static let size: CGSize = CGSizeMake(350, 80)
            static let height: CGFloat = 50
            static let width = 80%
            static let cornerRadius: CGFloat = 10
        }
        
        struct CollectionView {
            static let flowLayoutMinimumLineSpacing: CGFloat = 12
            static let marginTop: CGFloat = 10
        }
        
        struct Separators {
            static let marginTop: CGFloat = 10
            static let width: CGFloat = 1
        }
    }
}
