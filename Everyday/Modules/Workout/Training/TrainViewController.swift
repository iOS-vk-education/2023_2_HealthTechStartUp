//
//  TrainViewController.swift
//  Everyday
//
//  Created by Михаил on 13.05.2024.
//

import UIKit
import PinLayout

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
    
    // MARK: - lifecycle
    
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
                action: #selector(didTapCloseButton)
            )
        
        navigationItem.leftBarButtonItem?.tintColor = Constants.textColor
        navigationItem.rightBarButtonItem?.tintColor = Constants.textColor
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
        setupLabels()
        setupView()
        setupScrollView()
        
        infoImage.image = UIImage(named: "sh")
        
        infoLabel.attributedText = NSAttributedString(string: "Программа тренировок Арнольда Шварценеггера",
                                                      attributes: Styles.titleAttributes)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = 30

        scrollView.addSubviews(levelLabel, separator1, timeLabel, separator2, countLabel,
                               levelDescriptionLabel, timeDescriptionLabel, countDescriptionLabel,
                               descriptionTextLabel, collectionView)
        
        levelLabel.attributedText = NSAttributedString(string: "Профи", attributes: Styles.valueAttributes)
        timeLabel.attributedText = NSAttributedString(string: "2 месяца", attributes: Styles.valueAttributes)
        countLabel.attributedText = NSAttributedString(string: "24", attributes: Styles.valueAttributes)
        
       
        
        separator1.backgroundColor = .gray
        separator2.backgroundColor = .gray
        
        levelDescriptionLabel.attributedText = NSAttributedString(string: "Сложность",
                                                                  attributes: Styles.descriptionAttributes)
        timeDescriptionLabel.attributedText = NSAttributedString(string: "Длительность",
                                                                 attributes: Styles.descriptionAttributes)
        countDescriptionLabel.attributedText = NSAttributedString(string: "Тренировок",
                                                                  attributes: Styles.descriptionAttributes)
        
        
        // swiftlint:disable line_length
        descriptionTextLabel.text = "Берите пример с единственного и неповторимого семикратного победителя Олимпии Арнольда Шварценеггера. Тренировки Арнольда — образец программ с высокой частотой и большим объемом тренировочной нагрузки."
        // swiftlint:enable line_length
        
        downloadButton.layer.cornerRadius = 10
        downloadButton.backgroundColor = Constants.accentColor
        downloadButton.setTitleColor(Constants.textColor, for: .normal)
        downloadButton.setTitle("Загрузить", for: .normal)
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
        
        for label in [levelLabel, levelLabel, countLabel,
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
        
    }

    // MARK: - Layout
    
    private func layout() {
        infoImage.pin
            .top(view.pin.safeArea.top)
            .hCenter()
            .size(Constants.ImageView.size)
        
        infoLabel.pin
            .below(of: infoImage, aligned: .center)
            .marginTop(10)
            .size(Constants.Label.size)
            .sizeToFit(.width)
        
        infoView.pin
            .below(of: infoLabel, aligned: .center)
            .marginTop(10)
            .width(view.frame.width)
            .height(view.frame.height / 2 + 32)
        
        scrollView.pin
            .top()
            .width(infoView.frame.width)
            .height(infoView.frame.height - 80)
        
    let x = (infoView.frame.width - Constants.Label.descriptionSize.width * 3 - 2) / 6
    let spacing = (x * 100).rounded() / 100
        
        levelLabel.pin
            .top(10)
            .left(Constants.Label.marginHorizontal)
            .size(Constants.Label.descriptionSize)
        
        separator1.pin
            .top(10)
            .after(of: levelLabel)
            .marginLeft(Constants.Label.marginHorizontal)
            .height(levelLabel.frame.height * 2)
            .width(1)
        
        timeLabel.pin
            .top(10)
            .after(of: separator1)
            .marginLeft(spacing)
            .height(Constants.Label.descriptionSize.height)
            .width(Constants.Label.descriptionSize.width)
        
        separator2.pin
            .top(10)
            .after(of: timeLabel)
            .marginLeft(Constants.Label.marginHorizontal)
            .height(levelLabel.frame.height * 2)
            .width(1)
        
        countLabel.pin
            .top(10)
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
                .marginTop(2)
                .hCenter()
                .width(infoView.frame.width - Constants.Label.marginHorizontal * 2)
                .height(130)
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let collectionViewHeight = CGFloat(numberOfItems) * 66 + CGFloat(numberOfItems - 1) * Constants.CollectionView.flowLayoutMinimumLineSpacing + 10
            
        collectionView.pin
            .below(of: descriptionTextLabel, aligned: .center)
            .marginTop(10)
            .width(infoView.frame.width)
            .height(collectionViewHeight)
        
        scrollView.contentSize = CGSize(width: infoView.frame.width, height: collectionView.frame.maxY + 20)
        
        downloadButton.pin
            .below(of: scrollView)
            .hCenter()
            .width(Constants.Button.width)
            .height(Constants.Button.height + 10)
    }
    
    // MARK: - actions
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension TrainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else {
            return .init()
        }
        
        cell.titleLabel.text = ("Упражнение \(indexPath.item + 1)")
        
        let descTitles = ["Жим штанги лежа",
                          "Подтягивания обратным хватом",
                          "Становая тяга со штангой",
                          ""
                         ]
        
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
            
            static let descriptionSize: CGSize = CGSizeMake(100, 40)
            static let marginHorizontal: CGFloat = 10
        }
        
        struct View {
            static let opacity: CGFloat = 0.1
            static let cornerRadius: CGFloat = 30
        }
        
        struct Button {
            static let size: CGSize = CGSizeMake(350, 70)
            static let height: CGFloat = 50
            static let width = 80%
        }
        
        struct CollectionView {
            static let flowLayoutMinimumLineSpacing: CGFloat = 12
        }
    }
    
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "SpaceGray") ?? .black,
            .font: UIFont(name: "Arial-Black", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)
        ]
        
        static let valueAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "SpaceGray") ?? .black,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
    }
}
