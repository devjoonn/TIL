//
//  EpisodesCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/2/23.
//

import UIKit

final class EpisodesCoordinator: Coordinator {
    private let episodesFactory: EpisodesFactory
    var navigation: UINavigationController
    
    init(navigation: UINavigationController, episodesFactory: EpisodesFactory) {
        self.navigation = navigation
        self.episodesFactory = episodesFactory
    }
    
    func start() {
        let controller = episodesFactory.makeModule()
        controller.title = "Episodes"
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
    
}
