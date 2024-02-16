//
//  SignInProtocols.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import Foundation

protocol SignInModuleInput {
    var moduleOutput: SignInModuleOutput? { get }
}

protocol SignInModuleOutput: AnyObject {
}

protocol SignInViewInput: AnyObject {
    func configure(with model: SignInViewModel)
}

protocol SignInViewOutput: AnyObject {
    func didLoadView()
}

protocol SignInInteractorInput: AnyObject {
}

protocol SignInInteractorOutput: AnyObject {
}

protocol SignInRouterInput: AnyObject {
}
