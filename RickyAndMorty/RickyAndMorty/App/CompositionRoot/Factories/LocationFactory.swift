//
//  LocationFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/10/23.
//

import UIKit

protocol LocationFactory {
    func makeModule(locationCoordinator: LocationCoordinator) -> UIViewController
}

struct LocationFactoryImp: LocationFactory {
    private(set) var urlLocations: String
    private(set) var appContainer: AppContainer
    
    func makeModule(locationCoordinator: LocationCoordinator) -> UIViewController {
        let controller = LocationViewController()
        return controller
    }
}
