//
//  OriginFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/10/23.
//

import UIKit
import Combine

protocol OriginFactory {
    func makeModule(coordinator: OriginCoordinator) -> UIViewController
}

struct OriginFactoryImp: OriginFactory {
    func makeModule(coordinator: OriginCoordinator) -> UIViewController {
        UIViewController()
    }
}
