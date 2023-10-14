//
//  CharactersFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/14/23.
//

import UIKit

protocol CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController
    
}

struct CharactersFactoryImp: CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let controller = CharactersViewController()
        controller.title = "Characters"
        return controller
    }
}
