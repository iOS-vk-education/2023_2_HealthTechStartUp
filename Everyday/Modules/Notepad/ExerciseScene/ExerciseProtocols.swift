//
//  ExerciseProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import Foundation

protocol ExerciseModuleInput {
    var moduleOutput: ExerciseModuleOutput? { get }
}

protocol ExerciseModuleOutput: AnyObject {
    func setResult(of exercise: String, with result: String, at indexOfSet: Int)
}

protocol ExerciseViewInput: AnyObject {
    func configure(with viewModel: ExerciseViewModel)
    func updateResult(with result: String)
}

protocol ExerciseViewOutput: AnyObject {
    func didLoadView()
    func didTapSaveButton()
    func didTapCloseButton()
    func didTapPlusButton()
    func didTapMinusButton()
}

protocol ExerciseInteractorInput: AnyObject {
}

protocol ExerciseInteractorOutput: AnyObject {
}

protocol ExerciseRouterInput: AnyObject {
    func closeExercise()
}
