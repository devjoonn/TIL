//
//  AppFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/9/23.
//
import UIKit

protocol AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator
}

struct AppFactoryImp: AppFactory {
    
    let appContainer = AppContainerImp()
    
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let homeFactory = HomeFactoryImp(appContainer: appContainer)
        let homeCoordinator = HomeCoordinator(navigation: navigation, homeFactory: homeFactory)
        return homeCoordinator
    }
}
