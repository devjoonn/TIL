//
//  CharactersCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/14/23.
//

import UIKit

final class CharactersCoordinator: Coordinator {
    var navigation: UINavigationController
    private var charactersFactory: CharactersFactory
    
    init(navigation: UINavigationController, charactersFactory: CharactersFactory) {
        self.navigation = navigation
        self.charactersFactory = charactersFactory
    }
    
    func start() {
        let controller = charactersFactory.makeModule(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
    
}

extension CharactersCoordinator: CharactersViewControllerCoordinator {
    func didSelectCell(urlDetail: String) {
        let characterDetailCoordinator = charactersFactory.makeCharacterDetailCoordinator(navigation: navigation, urlList: urlDetail)
        characterDetailCoordinator.start()
    }
}
