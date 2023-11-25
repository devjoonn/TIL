//
//  LocationDetailCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/26/23.
//

import UIKit

final class LocationDetailCoordinator: Coordinator {
    private let locationDetailFactory: LocationDetailFactory
    var navigation: UINavigationController
    
    init(locationDetailFactory: LocationDetailFactory, navigation: UINavigationController) {
        self.locationDetailFactory = locationDetailFactory
        self.navigation = navigation
    }
    
    func start() {
        let controller = locationDetailFactory.makeModule(locationDetailCoordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
    
    
}
