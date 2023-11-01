//
//  CharacterDetailFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/29/23.
//

import UIKit
import Combine

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
}

struct CharacterDetailFactoryImp: CharacterDetailFactory {
    let urlDetail: String
    let appContainer: AppContainer
    
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let controller = CharacterDetailViewController()
        return controller
    }
}
