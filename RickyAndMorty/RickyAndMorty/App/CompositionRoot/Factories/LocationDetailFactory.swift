//
//  LocationDetailFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/26/23.
//

import UIKit

protocol LocationDetailFactory {
    func makeModule(locationDetailCoordinator: LocationDetailCoordinator) -> UIViewController
}

struct LocationDetailFactoryImp: LocationDetailFactory {
    func makeModule(locationDetailCoordinator: LocationDetailCoordinator) -> UIViewController {
        let controller = LocationDetailViewController()
        return controller
    }
}
