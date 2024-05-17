//
//  CatalogProtocols.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import Foundation

protocol CatalogModuleInput {
    var moduleOutput: CatalogModuleOutput? { get }
    func setTrains(_ trains: [Train], _ type: String)
}

protocol CatalogModuleOutput: AnyObject {
}

protocol CatalogViewInput: AnyObject {
    func configure(with viewModel: CatalogViewModel)
    func showAlert(with type: AlertType)
    func configureCell(with model: ExercisePreviewViewModel, and indexPath: IndexPath)
}

protocol CatalogViewOutput: AnyObject {
    func didLoadView()
    func getCount() -> Int
    func getTrains() -> [Train]
    func configureCell(for train: Train, at indexPath: IndexPath) async 
}

protocol CatalogInteractorInput: AnyObject {
}

protocol CatalogInteractorOutput: AnyObject {
}

protocol CatalogRouterInput: AnyObject {
}
