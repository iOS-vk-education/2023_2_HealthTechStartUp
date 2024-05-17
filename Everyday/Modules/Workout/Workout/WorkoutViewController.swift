//
//  WorkoutViewController.swift
//  workout
//
//  Created by Михаил on 21.03.2024.
//  
//

import UIKit
import PinLayout

final class WorkoutViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: WorkoutViewOutput
    
    private let controllersScrollView: UIScrollView = UIScrollView()
    private var programsViewController: UIViewController?
    private var walkProgramsViewController: UIViewController?
    private var activePage: ActiveProgramPage = .programs

    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.CollectionView.flowLayoutMinimumLineSpacing
        return layout
    }()
    
    private let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 4))
    private var isLinePositioned = false
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backgroundColor
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
            
    // MARK: - lifecycle
    
    init(output: WorkoutViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        output.didLoadView()
        output.getPrograms()
        output.getWalkPrograms()
        setupUI()
        
        view.addSubview(collectionView)
        view.addSubview(controllersScrollView)
        collectionView.addSubview(lineView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        arrangement()
        
        if !isLinePositioned {
            DispatchQueue.main.async {
                if let firstCell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
                    self.positionLineViewUnderCell(firstCell)
                    self.isLinePositioned = true
                }
            }
        }
    }
    
    // MARK: - SetUp
    
    private func setupUI() {
        setupLine()
        setupScrollView()
    }
    
    private func setupLine() {
        lineView.backgroundColor = UIColor(named: "SpaceGray")
        lineView.layer.cornerRadius = Constants.Lines.cornerRadius
    }
    
    private func setupScrollView() {
        guard let programs = programsViewController, let walkPrograms = walkProgramsViewController else {
            return
        }
        
        controllersScrollView.bounces = false
        controllersScrollView.layer.masksToBounds = true
        controllersScrollView.contentSize.width = programs.view.frame.width + walkPrograms.view.frame.width
        controllersScrollView.showsVerticalScrollIndicator = false
        controllersScrollView.showsHorizontalScrollIndicator = false
        controllersScrollView.delegate = self
        controllersScrollView.isPagingEnabled = true
        controllersScrollView.isScrollEnabled = false
        
        controllersScrollView.addSubview(programs.view)
        controllersScrollView.addSubview(walkPrograms.view)
    }
    
    // MARK: - Layout
    
    private func arrangement() {
        collectionView.pin
            .top(view.pin.safeArea.top)
            .left()
            .right()
            .height(Constants.CollectionView.height)
        
        let scrollViewHeight = view.frame.height - collectionView.frame.maxY

        controllersScrollView.pin
            .below(of: collectionView)
            .marginTop(Constants.ControllersScrollView.marginTop)
            .left()
            .right()
            .height(scrollViewHeight)

        let scrollViewWidth = view.frame.width

        programsViewController?.view.pin
            .topLeft()
            .width(scrollViewWidth)
            .height(scrollViewHeight)

        walkProgramsViewController?.view.pin
            .top()
            .after(of: programsViewController?.view ?? UIView())
            .width(scrollViewWidth)
            .height(scrollViewHeight)

        controllersScrollView.contentSize = CGSize(width: scrollViewWidth * 2, height: scrollViewHeight)
    }
    
    private func positionLineViewUnderCell(_ cell: UICollectionViewCell) {
        let lineX = cell.frame.origin.x + (cell.frame.size.width / 2) - (lineView.frame.size.width / 2)
        let lineY = cell.frame.maxY - lineView.frame.size.height - 2

        lineView.frame = CGRect(x: lineX, y: lineY, width: lineView.frame.size.width, height: lineView.frame.size.height)
    }
}

extension WorkoutViewController: WorkoutViewInput {
    func setPrograms(_ view: UIViewController) {
        programsViewController = view
        if let programsVC = view as? ProgramsViewController {
            programsVC.delegate = self
        }
    }
    
    func setWalkPrograms(_ view: UIViewController) {
        walkProgramsViewController = view
    }
}

// MARK: - UIScrollViewDelegate

extension WorkoutViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        activePage = pageIndex == 0 ? .programs : .walkPrograms
    }
}

// MARK: - Collection View data source

extension WorkoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as? TextCell else {
            return .init()
        } 
        
        if indexPath.item == 0 {
            cell.setText("Программы", isActive: true)
        } else {
            cell.setText("Ходьба и бег", isActive: false)
        }
       
        return cell
    }
}

// MARK: - Collection View delegate

extension WorkoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for cell in collectionView.visibleCells {
            guard let textCell = cell as? TextCell else {
                continue
            }
            textCell.setText(isActive: false)
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? TextCell {
            cell.setText(isActive: true)
            
            UIView.animate(withDuration: 0.3) {
                let lineX = cell.frame.origin.x + (cell.frame.size.width / 2) - (self.lineView.frame.size.width / 2)
                let lineY = cell.frame.maxY - self.lineView.frame.size.height - 2
                
                self.lineView.frame = CGRect(x: lineX, y: lineY, width: self.lineView.frame.size.width, height: self.lineView.frame.size.height)
            }
        }
        
        let pageWidth = view.frame.width
        let newOffset = CGFloat(indexPath.item) * pageWidth
        controllersScrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
        
        activePage = indexPath.item == 0 ? .programs : .walkPrograms
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - Collection View FlowLayout delegate

extension WorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension WorkoutViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            searchController.searchBar.showsCancelButton = true
            
            self.navigationItem.searchController = searchController
        }
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.searchController = nil
        
        searchController.searchBar.showsCancelButton = false
        view.addSubview(searchController.searchBar)
        arrangement()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
    }
}

extension WorkoutViewController: ProgramsViewControllerDelegate {
    func programsViewControllerRequestsPresentation(_ viewController: UIViewController) {
        output.loadCatalogViewController(viewController)
    }
}

// MARK: - Constants

extension WorkoutViewController {
    struct Constants {
        static let backgroundColor = UIColor(named: "Ghost")
        
        struct CollectionView {
            static let flowLayoutMinimumLineSpacing: CGFloat = 12
            static let height: CGFloat = 50
        }
        
        struct Lines {
            static let cornerRadius: CGFloat = 2
        }
        
        struct SearchController {
            static let marginTop: CGFloat = 12
            static let horizontal: CGFloat = 12
            static let height: CGFloat = 40
        }
        
        struct ControllersScrollView {
            static let marginTop: CGFloat = 12
        }
    }
}
