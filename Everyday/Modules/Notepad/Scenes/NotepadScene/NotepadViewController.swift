//
//  NotepadViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit
import PinLayout

final class NotepadViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: NotepadViewOutput
    
    private var outerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let stateLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let emptyStateView = EmptyStateView()
    
    // MARK: - Init

    init(output: NotepadViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.didLoadView()
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

private extension NotepadViewController {
    
    // MARK: - Layout
    
    func layout() {
        outerCollectionView.pin
            .horizontally()
            .top(view.pin.safeArea)
            .height(Constants.OuterCollectionView.height)
            .marginTop(Constants.OuterCollectionView.marginTop)
        
        stateLabel.pin
            .below(of: outerCollectionView)
            .marginTop(Constants.HeaderLabel.marginTop)
            .horizontally(Constants.HeaderLabel.horizontalMargin)
            .height(Constants.HeaderLabel.height)

        tableView.pin
            .below(of: stateLabel)
            .marginTop(Constants.TableView.marginTop)
            .horizontally()
            .bottom()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupOuterCollectionView()
        setupTableView()
        view.addSubviews(outerCollectionView, stateLabel, tableView)
    }

    func setupView() {
        view.backgroundColor = Constants.backgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dateLabel())
    }
    
    func setupOuterCollectionView() {
        outerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
        outerCollectionView.dataSource = self
        outerCollectionView.delegate = self
        outerCollectionView.register(NotepadOuterCollectionViewCell.self, forCellWithReuseIdentifier: NotepadOuterCollectionViewCell.reuseID)
        
        outerCollectionView.backgroundColor = .clear
        
        outerCollectionView.showsHorizontalScrollIndicator = false
        outerCollectionView.showsVerticalScrollIndicator = false
        outerCollectionView.isPagingEnabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else {
                return
            }
            
            let indexPath = IndexPath(item: 2, section: 0)
            outerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func setupTableView() {
        tableView.backgroundColor = Constants.backgroundColor
        tableView.contentInset = UIEdgeInsets(
            top: Constants.TableView.contentInsetTop,
            left: Constants.TableView.contentInsetLeft,
            bottom: Constants.TableView.contentInsetBottom,
            right: Constants.TableView.contentInsetRight
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotepadTableViewCell.self, forCellReuseIdentifier: NotepadTableViewCell.reuseID)
    }
    
    // MARK: - Custom Views
    
    func dateLabel() -> UILabel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateLabel.dateFormat
        
        let currentDate = dateFormatter.string(from: Date())
        
        let dateLabel = UILabel()
        dateLabel.text = currentDate.capitalized
        
        return dateLabel
    }
    
    // MARK: - Actions
    
    @objc
    func didTapHeaderView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        
        output.didTapHeaderView(number: view.tag)
    }
    
    @objc
    func didTapCollapseButton(_ button: UIButton) {
        var indexPaths = [IndexPath]()
        
        let section = button.tag
        let exercises = output.getExercises(at: section)
        for exerciseIndex in 0..<exercises.count {
            let indexPath = IndexPath(row: exerciseIndex, section: section)
            indexPaths.append(indexPath)
        }
        
        if output.toggleCollapsed(at: section) {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}

// MARK: - CollectionViewDataSource

extension NotepadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.collectionNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = outerCollectionView.dequeueReusableCell(withReuseIdentifier: NotepadOuterCollectionViewCell.reuseID, 
                                                                 for: indexPath) as? NotepadOuterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let week = output.collectionItem(at: indexPath.item)
        var selectedIndexPath: IndexPath?
        let first = output.getSelectedCellOuterIndexPath()
        let second = output.getShouldDeselectCellOuterIndexPath()
        if first == indexPath && second != indexPath {
            selectedIndexPath = output.getSelectedCellInnerIndexPath()
        }
        cell.configure(with: week, and: selectedIndexPath)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - NotepadOuterCollectionViewCellDelegate

extension NotepadViewController: NotepadOuterCollectionViewCellDelegate {
    func didTapInnerCollectionViewCell(_ date: Date) {
        output.didTapNewDate(date)
        output.setShouldDeselectCell(output.getSelectedCell())
        if let selectedCell = output.getSelectedCell(),
            let cell = outerCollectionView.cellForItem(at: selectedCell.outerIndex) as? NotepadOuterCollectionViewCell {
            cell.deselectCell()
        }
    }
}

// MARK: - CollectionViewDelegate

extension NotepadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = outerCollectionView.cellForItem(at: indexPath) as? NotepadOuterCollectionViewCell {
            if let innerIndexPath = cell.selectedCellIndexPath {
                output.setSelectedCell((indexPath, innerIndexPath))
            }
        }
    }
}

// MARK: - TableViewDataSource

extension NotepadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotepadTableViewCell.reuseID, for: indexPath) as? NotepadTableViewCell else {
            return UITableViewCell()
        }
        
        let exercise = output.getExercise(at: indexPath.section, at: indexPath.row)
        let viewModel = NotepadTableViewCellViewModel(exercise: exercise)
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - TableViewDelegate

extension NotepadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NotepadSectionHeaderView()
        
        let workoutDay = output.getWorkoutDay(section)
        let viewModel = NotepadHeaderViewModel(workoutDay: workoutDay)
        let headerViewState = output.headerViewState()
        headerView.configure(with: viewModel, and: section, state: headerViewState)
        headerView.addActions(self, viewAction: #selector(didTapHeaderView), buttonAction: #selector(didTapCollapseButton))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.TableView.headerHeight
    }
}

// MARK: - ViewInput

extension NotepadViewController: NotepadViewInput {
    func configure(with viewModel: NotepadViewModel) {
        stateLabel.attributedText = viewModel.stateTitle
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showEmptyStateView() {
        stateLabel.text = ""
        view.addSubview(emptyStateView)
        
        emptyStateView.pin
            .below(of: outerCollectionView)
            .horizontally()
            .bottom(view.pin.safeArea)
    }
    
    func dismissEmptyStateView() {
        guard emptyStateView.superview != nil else {
            return
        }
        
        emptyStateView.removeFromSuperview()
    }
    
    func showLoadingView() {
        view.addSubview(activityIndicator)
        
        activityIndicator.pin
            .hCenter()
            .vCenter()
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        activityIndicator.removeFromSuperview()
    }
}

// MARK: - Constants

private extension NotepadViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct DateLabel {
            static let dateFormat: String = "EEEE, d MMM"
        }
        
        struct HeaderLabel {
            static let height: CGFloat = 30
            static let horizontalMargin: CGFloat = 20
            static let marginTop: CGFloat = 20
        }
        
        struct OuterCollectionView {
            static let marginTop: CGFloat = 20
            static let height: CGFloat = 60
        }
        
        struct TableView {
            static let marginTop: CGFloat = 10
            static let contentInsetTop: CGFloat = 10
            static let contentInsetLeft: CGFloat = 0
            static let contentInsetBottom: CGFloat = 0
            static let contentInsetRight: CGFloat = 0
            static let headerHeight: CGFloat = 60
        }
    }
}