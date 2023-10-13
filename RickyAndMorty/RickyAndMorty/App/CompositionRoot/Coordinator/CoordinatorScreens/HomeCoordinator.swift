//
//  HomeCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/10/23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    private let homeFactory: HomeFactory
    
    init(navigation: UINavigationController, homeFactory: HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }
    
    func start() {
        let controller = homeFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: HomeMenuControllerCoordinator {
    func didSelectMenuCell(model: MenuItem) {
        switch model.title {
        case "characters":
            goToCharacters()
        case "episodes":
            goToEpisodes()
        case "locations":
            goToLocations()
        default:
            break
        }
    }
    
    private func goToCharacters() {
        print("Characters")
    }
    
    private func goToEpisodes() {
        print("Episodes")
    }
    
    private func goToLocations() {
        print("Locations")
    }
}
