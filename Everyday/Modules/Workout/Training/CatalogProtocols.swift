//
//  CatalogProtocols.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import UIKit

protocol CatalogModuleInput {
    var moduleOutput: CatalogModuleOutput? { get }
    func setTrains(_ trains: [Train], _ type: String)
}

protocol CatalogModuleOutput: AnyObject {
}

protocol CatalogViewInput: AnyObject {
    func configure(with viewModel: CatalogViewModel)
    func showAlert(with type: AlertType)
}

protocol CatalogViewOutput: AnyObject {
    func didLoadView()
    func getCount() -> Int
    func getTrains() -> [Train]
    func configureCell(for train: Train, at indexPath: IndexPath) async throws -> ExercisePreviewViewModel
    func didSelectCell(train: Train, image: UIImage)
}

protocol CatalogInteractorInput: AnyObject {
}

protocol CatalogInteractorOutput: AnyObject {
}

protocol CatalogRouterInput: AnyObject {
   func openCell(train: Train, image: UIImage)
}
