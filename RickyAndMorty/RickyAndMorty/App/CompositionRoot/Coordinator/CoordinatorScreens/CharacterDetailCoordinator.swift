//
//  CharacterDetailCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/29/23.
//

import UIKit

final class CharacterDetailCoordinator: Coordinator {
    var navigation: UINavigationController
    private var characterDetailFactory: CharacterDetailFactory
    
    init(navigation: UINavigationController, characterDetailFactory: CharacterDetailFactory) {
        self.navigation = navigation
        self.characterDetailFactory = characterDetailFactory
    }
    
    func start() {
        let controller = characterDetailFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

// DetailCoordinator에 CharacterDetailViewControllerCoordinator Delegate를 연결
extension CharacterDetailCoordinator: CharacterDetailViewControllerCoordinator {
    func didTapOriginButton() {
        let originCoordinator = characterDetailFactory.makeOriginCoordinator(navigation: navigation)
        originCoordinator.start()
    }
    
    func didTapLocationButton() {
        let locationCoordinator = characterDetailFactory.makeLocationCoordinator(navigation: navigation)
        locationCoordinator.start()
    }
}
