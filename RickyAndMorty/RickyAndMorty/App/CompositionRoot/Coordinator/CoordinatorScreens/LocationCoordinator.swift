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
    
    init(locationFactory: LocationFactory, navigation: UINavigationController) {
        self.locationFactory = locationFactory
        self.navigation = navigation
    }
    
    func start() {
        let controller = locationFactory.makeModule(locationCoordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
