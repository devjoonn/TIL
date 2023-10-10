//
//  HomeFactory.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/10/23.
//
import UIKit

protocol HomeFactory {
    func makeModule() -> UIViewController
}

struct  HomeFactoryImp: HomeFactory {
    func makeModule() -> UIViewController {
        let homeMenuController = HomeMenuController()
        homeMenuController.title = "Rick and Morty"
        return homeMenuController
    }
    
}
