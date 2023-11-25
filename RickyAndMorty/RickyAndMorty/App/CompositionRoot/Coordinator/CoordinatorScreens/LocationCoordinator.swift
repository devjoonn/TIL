//
//  LocationCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/10/23.
//

import UIKit

final class LocationCoordinator: Coordinator {
    private var locationFactory: LocationFactory
    var navigation: UINavigationController
    
    init(navigation: UINavigationController, locationFactory: LocationFactory) {
        self.navigation = navigation
        self.locationFactory = locationFactory
    }
    
    func start() {
        let controller = locationFactory.makeModule(locationCoordinator: self)
        controller.title = "Location"
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}
