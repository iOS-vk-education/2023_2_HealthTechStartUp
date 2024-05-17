//
//  CatalogViewController.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import UIKit
import PinLayout

final class CatalogViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: CatalogViewOutput
    private let titleLabel = UILabel()
    
    private var trains: [Train]?
    
    private lazy var clayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.CollectionView.minimumLineSpacing
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: clayout)
        collectionView.backgroundColor = Constants.background
        collectionView.register(TrainPreviewCell.self, forCellWithReuseIdentifier: "TrainPreviewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    // MARK: - Lifecycle

    init(output: CatalogViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.background
        
        setup()
        
        output.didLoadView()
        
        view.addSubviews(titleLabel, collectionView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(didTapCloseButton)
            )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - setup
    
    private func setup() {
        titleLabel.textAlignment = .center
    }
    
    // MARK: - layout
    
    private func layout() {
        titleLabel.pin
            .top(view.pin.safeArea.top)
            .hCenter()
            .size(Constants.Label.size)
        
        collectionView.pin
           .below(of: titleLabel)
           .marginTop(10)
           .horizontally(0)
           .bottom(view.pin.safeArea.bottom)
    }
    
    // MARK: - actions
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CatalogViewController: CatalogViewInput {
    func configureCell(with model: ExercisePreviewViewModel, and indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainPreviewCell", for: indexPath) as? TrainPreviewCell,
              let trains = trains
        else {
            return
        }
        
        cell.configure(with: model)
    }
    
    func showAlert(with type: AlertType) {
        AlertService.shared.presentAlert(on: self, alertType: type)
    }
    
    func configure(with viewModel: CatalogViewModel) {
        titleLabel.attributedText = viewModel.title
        trains = output.getTrains()
    }
}

// MARK: - UICollectionViewDelegate

extension CatalogViewController: UICollectionViewDelegate {
}

// MARK: - CatalogViewController: UICollectionViewDataSource

extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainPreviewCell", for: indexPath) as? TrainPreviewCell,
              let trains = trains
        else {
            return .init()
        }
        
        let train = trains[indexPath.row]
        Task {
            do {
                await output.configureCell(for: train, at: indexPath)
            }
        }
        
        return cell
    }
}

// MARK: - CatalogViewController: UICollectionViewDelegateFlowLayout

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2 - 20, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 6, left: 10, bottom: 0, right: 10)
    }
}

// MARK: - Constants

private extension CatalogViewController {
    struct Constants {
        static let background: UIColor = UIColor.background
        static let textColor: UIColor = UIColor.Text.primary
        
        struct CollectionView {
            static let minimumLineSpacing: CGFloat = 10
        }
        
        struct Label {
            static let size: CGSize = CGSize(width: 200, height: 50)
        }
    }
}
