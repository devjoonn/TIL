//
//  OriginCoordinator.swift
//  RickyAndMorty
//
//  Created by 박현준 on 11/10/23.
//

import UIKit

final class OriginCoordinator: Coordinator {
    private var originFactory: OriginFactory
    var navigation: UINavigationController
    
    init(originFactory: OriginFactory, navigation: UINavigationController) {
        self.originFactory = originFactory
        self.navigation = navigation
    }
    
    func start() {
        let controller = originFactory.makeModule(coordinator: self)
        controller.title = "Origin"
        navigation.pushViewController(controller, animated: true)
    }
}
