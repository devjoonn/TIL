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
    func makeModule(locationCoordinator: LocationCoordinator) -> UIViewController {
        return UIViewController()
    }
}
