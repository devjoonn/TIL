//
//  EpisodesFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 12/2/23.
//

import UIKit

protocol EpisodesFactory {
    func makeModule() -> UIViewController
}

struct EpisodesFactoryImp: EpisodesFactory {
    private(set) var urlEpisodes: String
    private(set) var appContainer: AppContainer
    
    
    func makeModule() -> UIViewController {
        let controller = EpisodesViewController()
        return controller
    }
}
