//
//  SearchResultsViewController.swift
//  workout
//
//  Created by Михаил on 06.04.2024.
//

import UIKit

class SearchResultsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func updateSearchResults(for searchText: String) {
           // Отфильтруйте и обновите данные на основе searchText
    }
}
